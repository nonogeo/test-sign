resource "google_kms_key_ring" "keyring" {
  name     = "keyring-test"
  location = "europe-north1"
  project  = var.project_id
}

resource "google_kms_crypto_key" "example-asymmetric-sign-key-euno1" {
  name     = "crypto-asymetric-key-example-hsm"
  key_ring = google_kms_key_ring.keyring.id
  purpose  = "ASYMMETRIC_SIGN"

  version_template {
    algorithm        = "EC_SIGN_P384_SHA384"
    protection_level = "HSM"
  }

  lifecycle {
    prevent_destroy = true
  }
}
