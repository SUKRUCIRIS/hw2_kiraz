#ifndef KIRAZ_STMT_OPERATOR_H
#define KIRAZ_STMT_OPERATOR_H
#include "Base.h"

namespace kiraz::stmt {

class Operator : public kiraz::Stmt {
private:
    unsigned char type; // 0 OP_PLUS, 1 OP_MINUS, 2 OP_MULT, 3 OP_DIVF
    std::shared_ptr<kiraz::Stmt> left;
    std::shared_ptr<kiraz::Stmt> right;

public:
    Operator(unsigned char type, std::shared_ptr<kiraz::Stmt> left,
            std::shared_ptr<kiraz::Stmt> right)
            : left(left), right(right), type(type) {}
    std::string get_repr() const override {
        switch (type) {
        case 0:
            return "OP_PLUS(l=" + left->get_repr() + ", r=" + right->get_repr() + ")";
        case 1:
            return "OP_MINUS(l=" + left->get_repr() + ", r=" + right->get_repr() + ")";
        case 2:
            return "OP_MULT(l=" + left->get_repr() + ", r=" + right->get_repr() + ")";
        case 3:
            return "OP_DIVF(l=" + left->get_repr() + ", r=" + right->get_repr() + ")";
        default:
            return "UNKNOWN TYPE :3";
        }
    }
};
}

#endif