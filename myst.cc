#include <iostream>
#include <cstdio>
#include <string>
#include <algorithm>
#include <cstring>
#include <cassert>
#include <unordered_map>
#include <sstream>
#include <fstream>
#include <codecvt>
#include "tqdm-cpp/tqdm.hpp"

const int oo = 1<<25;

int root, last_added, pos, needSL, remainderasdf,
	active_node, active_e, active_len;

using CharT = wchar_t;

struct Node {
/*
   There is no need to create an "Edge" struct.
   Information about the edge is stored right in the node.
   [start; end) interval specifies the edge,
   by which the node is connected to its parent node.
*/

	int start, end, slink;
	std::unordered_map<CharT, int> next;	

	int edge_length() {
		return std::min(end, pos + 1) - start;
	}
};

CharT* text = nullptr;
Node* tree = nullptr;

void printBT(const std::string& prefix, const int node, bool isLeft)
{
    bool is_first = true;
    for (const auto& pair : tree[node].next) {
        if (int child = pair.second; child != 0) {
            std::cout << prefix;
            std::cout << (isLeft ? "├──" : "└──" );
            std::wcout << std::wstring(text+tree[child].start, tree[child].edge_length()) << std::endl;
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
	Node nd;
	nd.start = start;
	nd.end = end;
	nd.slink = 0;
	tree[++last_added] = nd;
	return last_added;
}

CharT active_edge() {
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
	remainderasdf = 0, active_node = 0, active_e = 0, active_len = 0;
	root = active_node = new_node(-1, -1);
}

void st_extend(CharT c) {
	text[++pos] = c;
	needSL = 0;
	remainderasdf++;
	while(remainderasdf > 0) {
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
		remainderasdf--;
		if (active_node == root && active_len > 0) { //rule 1
			active_len--;
			active_e = pos - remainderasdf + 1;
		} else
			active_node = tree[active_node].slink > 0 ? tree[active_node].slink : root; //rule 3
	}
}

int traverse(const CharT* query, int current_node) {
    // printf("============ %s ==========\n", query);
    // printBT(current_node);
    if (int query_len = wcslen(query); query_len > 0) {
        CharT c = query[0];
        if (current_node = tree[current_node].next[c]) {
            auto current_node_len = tree[current_node].edge_length();
            assert(current_node != root);
            if (int shorter_len = std::min(query_len, current_node_len),
                    rc = wcsncmp(query, text+tree[current_node].start, shorter_len);
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
    if (tree[node].next.empty()) {
        return 1;
    } else {
        int ret = 0;
        for (const auto& pair : tree[node].next) {
            if (int child = pair.second; child != 0) {
                ret += count_leaf(child);
            }
        }
        return ret;
    }
}

std::wstring readFile(const char* filename)
{
    std::wifstream wif(filename);
    wif.imbue(std::locale(std::locale(), new std::codecvt_utf8<wchar_t>));
    std::wstringstream wss;
    wss << wif.rdbuf();
    return wss.str();
}

#define DUMP(x) do { std::wcerr << #x ": " << x << "\n"; } while (0)

int main() {
    std::locale loc ("");
    std::locale::global (loc);
    std::wcin.imbue(loc);
    std::wcout.imbue(loc);
    std::wstring query;

    auto input_string = readFile("/tmp/wiki.jsonl");
    std::cout << "String length: " << input_string.size() << std::endl;
    text = new CharT[input_string.size()+1];
    tree = new Node[2*input_string.size()+1];
    st_init();
    for (CharT c: tq::tqdm(input_string)) {
        st_extend(c);
    }

    while (std::getline(std::wcin, query)) {
        auto node = traverse(query.c_str(), root);
        std::wcout << "Count of " << query << ": " << (node == -1 ? 0: count_leaf(node)) << std::endl;
    }
    delete text;
    delete tree;
    return 0;
}
