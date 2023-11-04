
#include <gtest/gtest.h>

#include <kiraz/stmt.h>

#include <kiraz/hw2-lexer.hpp>
#include <kiraz/hw2-parser.hpp>

extern int yydebug;

namespace kiraz {

TEST(hw2, add) {
    /* init */
    // yydebug = 1; // uncomment to your heart's content
    auto buffer = yy_scan_string("1 + 2;");

    /* perform */
    yyparse();

    /* verify */
    auto root = Stmt::get_root();
    ASSERT_TRUE(root);
    ASSERT_EQ(fmt::format("{}", *root), "OP_PLUS(l=Int(10, OP_PLUS, 1), r=Int(10, OP_PLUS, 2))");

    /* cleanup */
    yy_delete_buffer(buffer);
    Token::clear();
    Stmt::reset_root();
}

TEST(hw2, add_signed) {
    /* init */
    // yydebug = 1; // uncomment to your heart's content
    auto buffer = yy_scan_string("1 + -2;");

    /* perform */
    yyparse();

    /* verify */
    auto root = Stmt::get_root();
    ASSERT_TRUE(root);
    ASSERT_EQ(fmt::format("{}", *root), "OP_PLUS(l=Int(10, OP_PLUS, 1), r=Int(10, OP_MINUS, 2))");

    /* cleanup */
    yy_delete_buffer(buffer);
    Token::clear();
    Stmt::reset_root();
}

TEST(hw2, signed_add) {
    /* init */
    // yydebug = 1; // uncomment to your heart's content
    auto buffer = yy_scan_string("-1 + 2;");

    /* perform */
    yyparse();

    /* verify */
    auto root = Stmt::get_root();
    ASSERT_TRUE(root);
    ASSERT_EQ(fmt::format("{}", *root), "OP_PLUS(l=Int(10, OP_MINUS, 1), r=Int(10, OP_PLUS, 2))");

    /* cleanup */
    yy_delete_buffer(buffer);
    Token::clear();
    Stmt::reset_root();
}

TEST(hw2, add_mul) {
    /* init */
    // yydebug = 1; // uncomment to your heart's content
    auto buffer = yy_scan_string("1 + 2 * 3;");

    /* perform */
    yyparse();

    /* verify */
    auto root = Stmt::get_root();
    ASSERT_TRUE(root);
    ASSERT_EQ(fmt::format("{}", *root),
            "OP_PLUS("
            "l=Int(10, OP_PLUS, 1), "
            "r=OP_MULT(l=Int(10, OP_PLUS, 2), r=Int(10, OP_PLUS, 3))"
            ")");

    /* cleanup */
    yy_delete_buffer(buffer);
    Token::clear();
    Stmt::reset_root();
}

TEST(hw2, add__paren_mul) {
    /* init */
    // yydebug = 1; // uncomment to your heart's content
    auto buffer = yy_scan_string("1 + (2 * 3);");

    /* perform */
    yyparse();

    /* verify */
    auto root = Stmt::get_root();
    ASSERT_TRUE(root);
    ASSERT_EQ(fmt::format("{}", *root),
            "OP_PLUS("
            "l=Int(10, OP_PLUS, 1), "
            "r=OP_MULT(l=Int(10, OP_PLUS, 2), r=Int(10, OP_PLUS, 3))"
            ")");

    /* cleanup */
    yy_delete_buffer(buffer);
    Token::clear();
    Stmt::reset_root();
}

TEST(hw2, paren_mul__add) {
    /* init */
    // yydebug = 1; // uncomment to your heart's content
    auto buffer = yy_scan_string("(1 * 2) + 3;");

    /* perform */
    yyparse();

    /* verify */
    auto root = Stmt::get_root();
    ASSERT_TRUE(root);
    ASSERT_EQ(fmt::format("{}", *root),
            "OP_PLUS("
            "l=OP_MULT(l=Int(10, OP_PLUS, 1), r=Int(10, OP_PLUS, 2)), "
            "r=Int(10, OP_PLUS, 3)"
            ")");

    /* cleanup */
    yy_delete_buffer(buffer);
    Token::clear();
    Stmt::reset_root();
}

TEST(hw2, mul__paren_add) {
    /* init */
    // yydebug = 1; // uncomment to your heart's content
    auto buffer = yy_scan_string("1 * (2 + 3);");

    /* perform */
    yyparse();

    /* verify */
    auto root = Stmt::get_root();
    ASSERT_TRUE(root);
    ASSERT_EQ(fmt::format("{}", *root),
            "OP_MULT("
            "l=Int(10, OP_PLUS, 1), "
            "r=OP_PLUS(l=Int(10, OP_PLUS, 2), r=Int(10, OP_PLUS, 3))"
            ")");

    /* cleanup */
    yy_delete_buffer(buffer);
    Token::clear();
    Stmt::reset_root();
}

TEST(hw2, paren_add__mul) {
    /* init */
    // yydebug = 1; // uncomment to your heart's content
    auto buffer = yy_scan_string("(1 + 2) * 3;");

    /* perform */
    yyparse();

    /* verify */
    auto root = Stmt::get_root();
    ASSERT_TRUE(root);
    ASSERT_EQ(fmt::format("{}", *root),
            "OP_MULT("
            "l=OP_PLUS(l=Int(10, OP_PLUS, 1), r=Int(10, OP_PLUS, 2)), "
            "r=Int(10, OP_PLUS, 3)"
            ")");

    /* cleanup */
    yy_delete_buffer(buffer);
    Token::clear();
    Stmt::reset_root();
}

} // namespace kiraz
