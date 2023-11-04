#ifndef KIRAZ_STMT_BASE_H
#define KIRAZ_STMT_BASE_H

#include <kiraz/token.h>

namespace kiraz {

class Stmt {
public:
    Stmt(){};
    virtual ~Stmt();
    virtual std::string get_repr() const = 0;

    static const auto &get_root() { return s_root; }
    static void reset_root() { s_root.reset(); }

    template <typename T, typename... Args>
    static auto add(Args &&...args) {
        auto root = std::make_shared<T>(std::forward<Args>(args)...);
        return s_root = root;
    }

protected:
    static std::shared_ptr<Stmt> s_root;
};

} // namespace kiraz

template <>
struct fmt::formatter<kiraz::Stmt> : fmt::formatter<std::string> {
    format_context::iterator format(const kiraz::Stmt &stmt, format_context &ctx) const {
        return fmt::formatter<std::string>::format(stmt.get_repr(), ctx);
    }
};

#endif
