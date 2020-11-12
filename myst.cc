#include <iostream>
#include <cstdio>
#include <string>
#include <algorithm>
#include <cstring>
#include <cassert>

const int oo = 1<<25;
const int ALPHABET_SIZE = 256;
const int MAXN = 5000;

using namespace std;

int root, last_added, pos, needSL, remainder,
	active_node, active_e, active_len;

struct node {
/*
   There is no need to create an "Edge" struct.
   Information about the edge is stored right in the node.
   [start; end) interval specifies the edge,
   by which the node is connected to its parent node.
*/

	int start, end, slink;
	int next[ALPHABET_SIZE];	

	int edge_length() {
		return min(end, pos + 1) - start;
	}
};

node tree[2*MAXN];
char text[MAXN];

int node_str_len(int node) {
    return min(static_cast<int>(strlen(text)), tree[node].end) - tree[node].start;
}

void printBT(const std::string& prefix, const int node, bool isLeft)
{
    bool is_first = true;
    for (int i = 0; i < ALPHABET_SIZE; ++i) {
        if (int child = tree[node].next[i]; child != 0) {
            std::cout << prefix;
            std::cout << (isLeft ? "├──" : "└──" );
            std::cout << std::string(text+tree[child].start, node_str_len(child)) << std::endl;
            printBT( prefix + (isLeft ? "│  " : "   "), child, is_first);
            is_first = false;
        }
    }
}

void printBT(const int node)
{
    printBT("", node, false);
}

int new_node(int start, int end = oo) {
	node nd;
	nd.start = start;
	nd.end = end;
	nd.slink = 0;
	for (int i = 0; i < ALPHABET_SIZE; i++)
		nd.next[i] = 0;
	tree[++last_added] = nd;
	return last_added;
}

char active_edge() {
	return text[active_e];
}

void add_SL(int node) {
	if (needSL > 0) tree[needSL].slink = node;
	needSL = node;
}

bool walk_down(int node) {
	if (active_len >= tree[node].edge_length()) {
		active_e += tree[node].edge_length();
		active_len -= tree[node].edge_length();
		active_node = node;
		return true;
	}
	return false;
}

void st_init() {
	needSL = 0, last_added = 0, pos = -1, 
	remainder = 0, active_node = 0, active_e = 0, active_len = 0;
	root = active_node = new_node(-1, -1);
}

void st_extend(char c) {
	text[++pos] = c;
	needSL = 0;
	remainder++;
	while(remainder > 0) {
		if (active_len == 0) active_e = pos;
		if (tree[active_node].next[active_edge()] == 0) {
			int leaf = new_node(pos);
			tree[active_node].next[active_edge()] = leaf;
			add_SL(active_node); //rule 2
		} else {
			int nxt = tree[active_node].next[active_edge()];
			if (walk_down(nxt)) continue; //observation 2
			if (text[tree[nxt].start + active_len] == c) { //observation 1
				active_len++;
				add_SL(active_node); //observation 3
				break;
			}
			int split = new_node(tree[nxt].start, tree[nxt].start + active_len);
			tree[active_node].next[active_edge()] = split;
			int leaf = new_node(pos);
			tree[split].next[c] = leaf;
			tree[nxt].start += active_len;
			tree[split].next[text[tree[nxt].start]] = nxt;
			add_SL(split); //rule 2
		}
		remainder--;
		if (active_node == root && active_len > 0) { //rule 1
			active_len--;
			active_e = pos - remainder + 1;
		} else
			active_node = tree[active_node].slink > 0 ? tree[active_node].slink : root; //rule 3
	}
}

int traverse(const char* query, int current_node) {
    // printf("============ %s ==========\n", query);
    // printBT(current_node);
    if (int query_len = strlen(query); query_len > 0) {
        char c = query[0];
        if (current_node = tree[current_node].next[c]) {
            auto current_node_len = node_str_len(current_node);
            assert(current_node != root);
            if (int shorter_len = min(query_len, current_node_len),
                    rc = strncmp(query, text+tree[current_node].start, shorter_len);
                    rc == 0) {
                return traverse(query+shorter_len, current_node);
            } else {
                return -1;
            }
        } else {
            return -1;
        }
    } else {
        return current_node;
    }
}

int count_leaf(int node) {
    if (all_of(cbegin(tree[node].next), cend(tree[node].next), [](int i){return i == 0;})) {
        return 1;
    } else {
        int ret = 0;
        for (int i = 0; i < ALPHABET_SIZE; ++i) {
            if (int child = tree[node].next[i]; child != 0) {
                ret += count_leaf(child);
            }
        }
        return ret;
    }
}

int main() {
    st_init();
    for (char c: "cacaoaaccoacoccaoacoocacoacaoc$") {
        st_extend(c);
    }
    auto query = "cao";
    auto node = traverse(query, root);
    printf("Count of %s: %d\n", query, count_leaf(node));
	return 0;
}
