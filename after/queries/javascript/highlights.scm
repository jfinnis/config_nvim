;; extends

(("return" @return_statement) (#set! conceal "←"))
(("function" @keyword.function) (#set! conceal "λ"))
(((identifier) @NaN (#eq? @NaN "NaN")) (#set! conceal "ℕ"))
((undefined) @undefined (#set! conceal "¿"))
((null) @null (#set! conceal "∅"))
((this) @this (#set! conceal "の"))
(((property_identifier) @prototype (#eq? @prototype "prototype")) (#set! conceal "¶"))

; Replaced with actual font ligatures in VictorMono font
;(("=>" @operator.typescript) (#set! conceal "→"))
;(("===" @operator.typescript) (#set! conceal "〓"))
;(("!==" @operator.typescript) (#set! conceal "≠"))
;((">=" @operator.typescript) (#set! conceal "≥"))
;(("<=" @operator.typescript) (#set! conceal "≤"))
