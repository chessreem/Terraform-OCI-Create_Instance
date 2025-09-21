resource "oci_core_instance" "new_instance" {
  count = var.choose == "yes" ? 0 : 1

  availability_domain = var.oci_ad
  compartment_id      = var.compartment_id
  display_name        = var.instance_display_name
  shape               = "VM.Standard.E4.Flex"
  defined_tags        = var.schedule_tags

  availability_config {
    is_live_migration_preferred = "false"
    recovery_action             = "STOP_INSTANCE"
  }

  create_vnic_details {
    assign_public_ip       = "false"
    display_name           = var.instance_display_name
    hostname_label         = var.instance_display_name
    nsg_ids                = var.dev_and_ad_nsgs
    private_ip             = var.instance_private_ip
    skip_source_dest_check = "false"
    subnet_id              = var.dev_subnet_id
  }

  instance_options {
    are_legacy_imds_endpoints_disabled = "false"
  }

  launch_options {
    boot_volume_type                    = "PARAVIRTUALIZED"
    firmware                            = "UEFI_64"
    is_consistent_volume_naming_enabled = "true"
    network_type                        = "PARAVIRTUALIZED"
    remote_data_volume_type             = "PARAVIRTUALIZED"
  }

  platform_config {
    type                                 = "AMD_VM"
    is_measured_boot_enabled             = "true"
    is_memory_encryption_enabled         = "false"
    is_secure_boot_enabled               = "true"
    is_symmetric_multi_threading_enabled = "true"
    is_trusted_platform_module_enabled   = "true"
  }

  shape_config {
    baseline_ocpu_utilization = "BASELINE_1_1"
    memory_in_gbs             = var.instance_memory_in_gbs
    ocpus                     = var.instance_ocpus
  }

  source_details {
    source_id               = var.image_ocid
    source_type             = "image"
    boot_volume_size_in_gbs = var.boot_volume_size_in_gbs
    boot_volume_vpus_per_gb = var.boot_volume_vpus_per_gb
  }

}