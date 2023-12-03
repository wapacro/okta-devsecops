locals {
  # Ingress Firewall Rules for OPA Gateways
  gateway_ingress_rules = [
    {
      description = "OPA sftd: Incoming SSH connections (Gateway Management)"
      cidr        = "0.0.0.0/0"
      protocol    = "TCP"
      from_port   = 22
      to_port     = 22
    },
    {
      description = "OPA sftd: Incoming connections to help provision On Demand users (Gateway Management)"
      cidr        = "0.0.0.0/0"
      protocol    = "TCP"
      from_port   = 4421
      to_port     = 4421
    },
    {
      description = "OPA sft-gateway: Incoming connections from OPA client (Traffic Forwarding)"
      cidr        = "0.0.0.0/0"
      protocol    = "TCP"
      from_port   = 7234
      to_port     = 7234
    }
  ]

  # Egress Firewall Rules for OPA Gateways
  gateway_egress_rules = [
    {
      description = ""
      cidr        = "0.0.0.0/0"
      protocol    = "-1"
      from_port   = -1
      to_port     = -1
    }
  ]

  # Default Ingress Firewall Rules for Linux-based, OPA-managed servers
  linux_ingress_rules = [
    {
      description    = "OPA sftd: Incoming SSH connections"
      cidr           = null
      security_group = aws_security_group.opa_gateway_defaults.id
      protocol       = "TCP"
      from_port      = 22
      to_port        = 22
    },
    {
      description    = "OPA sftd: Incoming connections to help provision On Demand users"
      cidr           = null
      security_group = aws_security_group.opa_gateway_defaults.id
      protocol       = "TCP"
      from_port      = 4421
      to_port        = 4421
    },
  ]

  # Default Egress Firewall Rules for Linux-based, OPA-managed servers
  linux_egress_rules = [
    {
      description = ""
      cidr        = "0.0.0.0/0"
      protocol    = "-1"
      from_port   = -1
      to_port     = -1
    }
  ]

  # Default Ingress Firewall Rules for Windows-based, OPA-managed servers
  windows_ingress_rules = [
    {
      description    = "OPA sftd: Incoming AD-joined RDP sessions"
      cidr           = null
      security_group = aws_security_group.opa_gateway_defaults.id
      protocol       = "TCP"
      from_port      = 3389
      to_port        = 3389
    },
    {
      description    = "OPA sftd: Incoming connections to help provision On Demand users and proxy non-AD RDP sessions"
      cidr           = null
      security_group = aws_security_group.opa_gateway_defaults.id
      protocol       = "TCP"
      from_port      = 4421
      to_port        = 4421
    },
  ]

  # Default Egress Firewall Rules for Windows-based, OPA-managed servers
  windows_egress_rules = [
    {
      description = ""
      cidr        = "0.0.0.0/0"
      protocol    = "-1"
      from_port   = -1
      to_port     = -1
    }
  ]
}

resource "aws_security_group" "opa_gateway_defaults" {
  name        = "opa-gateway-defaults"
  description = "Default security group for OPA gateways"
}

resource "aws_security_group" "opa_linux_defaults" {
  name        = "opa-linux-defaults"
  description = "Default security group for Linux-based, OPA-managed servers"
}

resource "aws_security_group" "opa_windows_defaults" {
  name        = "opa-windows-defaults"
  description = "Default security group for Windows-based, OPA-managed servers"
}

resource "aws_vpc_security_group_ingress_rule" "opa_gateway_defaults_ingress_rules" {
  for_each = {
  for index, rule in local.gateway_ingress_rules :
  index => rule
  }

  security_group_id = aws_security_group.opa_gateway_defaults.id
  cidr_ipv4         = each.value.cidr
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.protocol
  description       = each.value.description
}

resource "aws_vpc_security_group_egress_rule" "opa_gateway_defaults_egress_rules" {
  for_each = {
  for index, rule in local.gateway_egress_rules :
  index => rule
  }

  security_group_id = aws_security_group.opa_gateway_defaults.id
  cidr_ipv4         = each.value.cidr
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.protocol
  description       = each.value.description
}

resource "aws_vpc_security_group_ingress_rule" "opa_linux_defaults_ingress_rules" {
  for_each = {
  for index, rule in local.linux_ingress_rules :
  index => rule
  }

  security_group_id            = aws_security_group.opa_linux_defaults.id
  referenced_security_group_id = each.value.security_group
  cidr_ipv4                    = each.value.cidr
  from_port                    = each.value.from_port
  to_port                      = each.value.to_port
  ip_protocol                  = each.value.protocol
  description                  = each.value.description
}

resource "aws_vpc_security_group_egress_rule" "opa_linux_defaults_egress_rules" {
  for_each = {
  for index, rule in local.linux_egress_rules :
  index => rule
  }

  security_group_id = aws_security_group.opa_linux_defaults.id
  cidr_ipv4         = each.value.cidr
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.protocol
  description       = each.value.description
}

resource "aws_vpc_security_group_ingress_rule" "opa_windows_defaults_ingress_rules" {
  for_each = {
  for index, rule in local.windows_ingress_rules :
  index => rule
  }

  security_group_id            = aws_security_group.opa_windows_defaults.id
  referenced_security_group_id = each.value.security_group
  cidr_ipv4                    = each.value.cidr
  from_port                    = each.value.from_port
  to_port                      = each.value.to_port
  ip_protocol                  = each.value.protocol
  description                  = each.value.description
}

resource "aws_vpc_security_group_egress_rule" "opa_windows_defaults_egress_rules" {
  for_each = {
  for index, rule in local.windows_egress_rules :
  index => rule
  }

  security_group_id = aws_security_group.opa_windows_defaults.id
  cidr_ipv4         = each.value.cidr
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.protocol
  description       = each.value.description
}
