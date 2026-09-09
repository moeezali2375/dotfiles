---
trigger: glob
globs: *.ts, *.tsx, *.mts, *.cts
description: TypeScript type safety, strict typing standards, and compiler directive guidelines.
---

# TypeScript Type Safety & Standards

Guidelines and rules for writing type-safe TypeScript code.

## 1. Strictly Avoid `any`
- **Zero `any` Policy**: Never use `any` as a type annotation, return type, or cast (`as any`).
- **Use `unknown`**: If a value is dynamic or genuinely unknown (e.g., external API responses, dynamic JSON, caught errors), use `unknown` instead of `any`.
- **Type Narrowing**: Always narrow `unknown` values before operating on them using:
  - Type guards (`typeof`, `instanceof`, `Array.isArray`, `in` operator)
  - Custom type predicates (`value is TargetType`)
  - Runtime validation libraries (e.g., Zod, Valibot) where appropriate.

## 2. Explicit & Precise Typing
- **Explicit Signatures**: Provide explicit parameter and return types for exported functions, public class methods, and API interfaces.
- **Discriminated Unions**: Prefer discriminated unions with a common tag/literal over loose optional fields when modeling state machines, events, or multi-variant responses.
- **Narrow Literals & Immutability**: Use `as const` for fixed lookup objects, configuration dictionaries, and immutable tuples.
- **Generics over Broad Types**: Use bounded generics (`<T extends Record<string, unknown>>`) rather than loose objects or untyped structures.

## 3. Safe Type Assertions
- **Avoid Unsafe Casts**: Minimize type assertions (`value as Type`). Treat them as a code smell unless narrowing is verified or interacting with poorly-typed third-party libraries.
- **No Force Non-Null**: Avoid the non-null assertion operator (`!`) unless guaranteed by preceding invariant assertions. Prefer optional chaining (`?.`) and nullish coalescing (`??`).

## 4. Compiler Directives & Suppressions
- **Forbidden Directives**: Do not use `@ts-ignore` or `@ts-nocheck`.
- **Targeted Suppressions**: If a compiler bug or impossible third-party type definition necessitates a suppression, use `@ts-expect-error` with a comment explaining why.
