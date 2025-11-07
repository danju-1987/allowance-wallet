;; --------------------------------------------------
;; Allowance Wallet Smart Contract
;; The contract owner can assign spending allowances to different users.
;; Spenders can withdraw up to their allowance amount.
;; Allowances can also be revoked or reduced.
;; --------------------------------------------------

(define-data-var owner principal tx-sender)

(define-map allowances
  {spender: principal}
  {amount: uint})

;; --------------------------------------------------
;; Read-Only Functions
;; --------------------------------------------------

(define-read-only (get-owner)
  ;; Returns the current owner
  (var-get owner)
)

(define-read-only (get-allowance (spender principal))
  ;; Returns allowance for a specific spender
  (default-to u0 (get amount (map-get? allowances {spender: spender})))
)

;; --------------------------------------------------
;; Public Functions
;; --------------------------------------------------

(define-public (set-allowance (spender principal) (amount uint))
  ;; Owner sets or updates allowance
  (begin
    (asserts! (is-eq tx-sender (var-get owner)) (err "Only owner can set allowance"))
    (map-set allowances {spender: spender} {amount: amount})
    (ok {spender: spender, allowance: amount})
  )
)

(define-public (revoke-allowance (spender principal))
  ;; Owner sets allowance to zero
  (begin
    (asserts! (is-eq tx-sender (var-get owner)) (err "Only owner can revoke allowance"))
    (map-set allowances {spender: spender} {amount: u0})
    (ok {spender: spender, allowance: u0})
  )
)

(define-public (withdraw (amount uint))
  ;; Spender withdraws from their allowance
  (let (
        (current (default-to u0 (get amount (map-get? allowances {spender: tx-sender}))))
       )
    (begin
      (asserts! (>= current amount) (err "Not enough allowance"))
      (map-set allowances {spender: tx-sender} {amount: (- current amount)})
      (ok {spender: tx-sender, withdrawn: amount, remaining: (- current amount)})
    )
  )
)

(define-public (transfer-ownership (new-owner principal))
  ;; Owner transfers contract ownership to another user
  (begin
    (asserts! (is-eq tx-sender (var-get owner)) (err "Only owner can transfer ownership"))
    (var-set owner new-owner)
    (ok new-owner)
  )
)
