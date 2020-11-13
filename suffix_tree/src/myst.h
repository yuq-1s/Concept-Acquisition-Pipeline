#ifndef __MYST_H
#define __MYST_H

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

template<typename CharT>
struct NodeT {
/*
There is no need to create an "Edge" struct.
Information about the edge is stored right in the node.
[start_; end) longerval specifies the edge,
by which the node is connected to its parent node.
*/

    NodeT(long start, long end) : start_(start), end_(end), slink_(nullptr) {}
    long start_, end_;
    mutable long leaf_count_ = -1;
    NodeT* slink_;
    std::unordered_map<CharT, std::unique_ptr<NodeT>> next;

    long string_length() const {
        return end_ - start_;
    }
};

template<typename CharT = char> class SuffixTree {
    std::basic_string<CharT> text_;
    using Node = NodeT<CharT>;
    Node* root_;

    Node* need_sl_ = root_;
    long remainder_ = 0;
    Node* active_node_ = root_;
    long active_edge_ = 0;
    long active_len_ = 0;
    long pos_ = -1;
    long input_string_length_;

    CharT active_edge_dge() {
        return text_[active_edge_];
    }

    void add_SL(Node* node) {
        if (need_sl_ != root_) need_sl_->slink_ = node;
        need_sl_ = node;
    }

    bool walk_down(Node* node) {
        if (long edge_length = std::min(node->end_, pos_ + 1) - node->start_; active_len_ >= edge_length) {
            active_edge_ += edge_length;
            active_len_ -= edge_length;
            active_node_ = node;
            return true;
        }
        return false;
    }

    std::basic_ostream<CharT>& printBT(std::basic_ostream<CharT>&, const std::basic_string<CharT>&, const Node*, bool) const;
    std::basic_ostream<CharT>& printBT(std::basic_ostream<CharT>&, const Node*) const;
    void st_extend(CharT c);
    const Node* traverse(const CharT* query, const Node* current_node) const;
    long count_leaf(const Node* node);
    static std::basic_string<CharT> readFile(const char* filename);

public:
    ~SuffixTree() {
        delete root_;
    }

    std::basic_ostream<CharT>& print(std::basic_ostream<CharT>& os) const {
        return printBT(os, root_);
    }
};

#endif // __MYST_H
