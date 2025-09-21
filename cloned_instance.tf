resource "oci_core_boot_volume" "cloned_boot_volume" {
  count = var.choose == "yes" ? 1 : 0

  availability_domain = var.oci_ad
  compartment_id      = var.compartment_id
  source_details {
    id   = var.boot_volume_ocid
    type = "bootVolume"
  }
  display_name = "${var.instance_display_name} (Boot Volume)"
  size_in_gbs  = var.boot_volume_size_in_gbs
  vpus_per_gb  = var.boot_volume_vpus_per_gb
}

resource "oci_core_instance" "instance_from_clone" {
  count = var.choose == "yes" ? 1 : 0

  availability_domain = var.oci_ad
  compartment_id      = var.compartment_id
  display_name        = var.instance_display_name
  shape               = var.shape
  defined_tags        = var.schedule_tags

  availability_config {
    is_live_migration_preferred = "false"
    recovery_action             = "STOP_INSTANCE"
  }

  create_vnic_details {
    assign_public_ip       = "false"
    display_name           = var.instance_display_name
    hostname_label         = var.instance_display_name
    nsg_ids                = var.nsgs
    private_ip             = var.instance_private_ip
    skip_source_dest_check = "false"
    subnet_id              = var.subnet_id
  }

  instance_options {
    #Optional
    are_legacy_imds_endpoints_disabled = "false"
  }

  launch_options {
    boot_volume_type                    = "PARAVIRTUALIZED"
    firmware                            = "UEFI_64"
    network_type                        = "PARAVIRTUALIZED"
    remote_data_volume_type             = "PARAVIRTUALIZED"
    is_consistent_volume_naming_enabled = "true"
  }

  platform_config {
    type = "AMD_VM"
    #Optional
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
    #vcpus = "4""
  }
  source_details {
    source_id   = oci_core_boot_volume.cloned_boot_volume[count.index].id
    source_type = "bootVolume"
  }

}