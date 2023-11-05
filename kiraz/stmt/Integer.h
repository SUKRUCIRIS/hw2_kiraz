#ifndef KIRAZ_STMT_INTEGER_H
#define KIRAZ_STMT_INTEGER_H
#include "Base.h"

namespace kiraz::stmt {

class Integer : public kiraz::Stmt {
private:
    bool is_positive;
    unsigned int base;
    std::string value;

public:
    Integer(bool is_positive, const kiraz::Token &token) {
        const kiraz::token::Integer &t_int = static_cast<const kiraz::token::Integer &>(token);
        this->is_positive = is_positive;
        this->base = t_int.get_base();
        this->value = t_int.get_value();
    }
    std::string get_repr() const override {
        return "Int(" + std::to_string(base) + ", " + (is_positive ? "OP_PLUS" : "OP_MINUS") + ", "
                + value + ")";
    }
};
}

#endif