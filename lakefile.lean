import Lake
open Lake DSL

package CleanMidnight where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩, -- pretty-prints `fun a ↦ b`
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩]

-- The proof roots, plus every module under Midnight.
@[default_target]
lean_lib Midnight where
  roots := #[`Midnight.SHA256.Semantics.Formal, `Midnight.SHA256.WitnessComplete, `Midnight.SHA256.Admission.Certificate]
  globs := #[.submodules `Midnight, .one `Midnight]
  allowNonModules := true

-- Lean half of the VK export tool (scripts/vk-export); not a default target.
lean_lib MidnightExport where
  globs := #[.submodules `MidnightExport]
  allowNonModules := true

-- Lowering replay fixtures (scripts/lowering-replay), one directory each; not a default target.
lean_lib LoweringFixtures where
  srcDir := "scripts/lowering-replay"
  globs := #[.submodules `LoweringFixtures]
  allowNonModules := true

-- ethereum/EthLib at 3bd2b3c, BLAKE2b compression only, vendored with per-file hashes
-- (scripts/ethlib-vendor/vendor.py --check); Midnight's key hash runs on its compression function.
lean_lib EthLib where
  srcDir := "vendor/ethlib"
  roots := #[`EthLib.Cryptography.Hash.Blake2b]
  allowNonModules := true

-- Clean (Halo2-Clean + Midnight extensions + ComputableWitnesses/WritesConsistent, PR #528).
require Clean from git
  "https://github.com/Verified-zkEVM/clean.git" @ "e777f353f16e705b441b12f4c0c1442292f8945e"
