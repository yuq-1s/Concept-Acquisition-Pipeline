#include "myst.h"

template<typename CharT>
std::basic_ostream<CharT>& SuffixTree::printBT(std::basic_ostream<CharT>& os, const std::basic_string<CharT>& prefix, const Node* node, bool isLeft) const {
    bool is_first = true;
    for (const auto& pair : node->next) {
        if (auto child = pair.second.get(); child != 0) {
            os << prefix;
            os << (isLeft ? L"├──" : L"└──" );
            for (auto i = 0; i < child->string_length(); ++i) {
                os << text_[child->start_+i];
            }
            os << std::endl;
            // os << std::basic_string<CharT>(text_.c_str() + child->start_, child->string_length()) << std::endl;
            printBT(os, prefix + (isLeft ? L"│  " : L"   "), child, is_first);
            is_first = false;
        }
    }
    return os;
}

template<typename CharT>
std::basic_ostream<CharT>& SuffixTree::printBT(std::basic_ostream<CharT>& os, const Node* node) const
{
    return printBT(os, L"", node, false);
}

template<typename CharT>
void SuffixTree::st_extend(CharT c) {
    // printBT(root_);
    pos_++;
    need_sl_ = root_;
    remainder_++;
    while(remainder_ > 0) {
        if (active_len_ == 0) active_edge_ = pos_;
        if (auto& table = active_node_->next; table.find(active_edge_dge()) == table.end()) {
            table[active_edge_dge()] = std::make_unique<Node>(pos_, text_.size());
            add_SL(active_node_); //rule 2
        } else {
            auto nxt = active_node_->next[active_edge_dge()].get();
            if (walk_down(nxt)) continue; //observation 2
            if (text_[nxt->start_ + active_len_] == c) { //observation 1
                active_len_++;
                add_SL(active_node_); //observation 3
                break;
            }
            auto split = new Node(nxt->start_, nxt->start_ + active_len_);
            auto foo = active_node_->next[active_edge_dge()].release();
            active_node_->next[active_edge_dge()].reset(split);
            split->next[c] = std::make_unique<Node>(pos_, text_.size());
            nxt->start_ += active_len_;
            split->next[text_[nxt->start_]] = std::unique_ptr<Node>(foo);
            add_SL(split); //rule 2
        }
        remainder_--;
        if (active_node_ == root_ && active_len_ > 0) { //rule 1
            active_len_--;
            active_edge_ = pos_ - remainder_ + 1;
        } else
            active_node_ = active_node_->slink_ ? active_node_->slink_ : root_; //rule 3
    }
}

template<typename CharT>
const Node* SuffixTree::traverse(const CharT* query, const Node* current_node) const {
    // printf("============ %s ==========\n", query);
    // printBT(std::wcout, current_node);
    if (long query_len = wcslen(query); query_len > 0) {
        if (auto next_node_iter = current_node->next.find(*query); next_node_iter != current_node->next.end()) {
            auto next_node = next_node_iter->second.get();
            assert(next_node != root_);
            if (long shorter_len = std::min(query_len, next_node->string_length()),
                    rc = wcsncmp(query, text_.c_str() + next_node->start_, shorter_len);
                    rc == 0) {
                return traverse(query+shorter_len, next_node);
            }
        }
        return nullptr;
    } else {
        return current_node;
    }
}

long SuffixTree::count_leaf(const Node* node) {
    if (node->leaf_count_ != -1) {
        return node->leaf_count_;
    } else {
        if (node->next.empty()) {
            return 1;
        } else {
            node->leaf_count_ = 0;
            for (const auto& pair : node->next) {
                if (auto child = pair.second.get(); child != root_) {
                    node->leaf_count_ += count_leaf(child);
                }
            }
            return node->leaf_count_;
        }
    }
}

template<typename CharT>
static std::basic_string<CharT> SuffixTree::readFile(const char* filename)
{
    std::basic_ifstream<CharT> wif(filename);
    wif.imbue(std::locale(std::locale(), new std::codecvt_utf8<CharT>));
    std::basic_stringstream<CharT> wss;
    wss << wif.rdbuf();
    return wss.str();
}

template<typename CharT>
SuffixTree::SuffixTree(const char* filename) : text_(readFile(filename)), root_(new Node(-1, -1)) {
    for (CharT c: tq::tqdm(text_)) {
        st_extend(c);
    }
    std::wcout << std::endl;
}

template<typename CharT>
long count_occurance(const CharT* query) {
    auto node = traverse(query, root_);
    return (node ? count_leaf(node) : 0);
}