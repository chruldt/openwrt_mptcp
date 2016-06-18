#
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# $Id: Makefile 5624 2006-11-23 00:29:07Z nbd $

include $(TOPDIR)/rules.mk

PKG_NAME:=mptcp

PKG_VERSION:=v3.18.26-0411d31b5311
PKG_RELEASE:=0.90
PKG_MD5SUM:=8cXXX8e449009b4d29512d26ee308960bb5

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).patch
#PKG_SOURCE_URL:=http://multipath-tcp.org/patches/mptcp-v4.1.20-856ebd0cac21.patch
PKG_SOURCE_URL:=http://multipath-tcp.org/patches/mptcp-v3.18.26-0411d31b5311.patch
PKG_LICENSE:=GPL-2.0

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel.mk

define KernelPackage/mptcp
  URL:=https://multipath-tcp.org/
  MAINTAINER:=Not Me <nospam@solvare.se>
  SUBMENU:=Network Support
  TITLE:=MPTCP
  AUTOLOAD:=$(call AutoLoad,50)
endef

define KernelPackage/mptcp/description
MPTCP is a re-take on TCP to support multiple flows using multiple
paths.
endef

define KernelPackage/mptcp/config
	source "$(SOURCE)/Config.in"
endef

PKG_EXTRA_KCONFIG:= \
        CONFIG_MPTCP=y\
        CONFIG_MPTCP_PM_ADVANCED=y\
        CONFIG_MPTCP_FULLMESH=y\
        CONFIG_MPTCP_NDIFFPORTS=y\
        CONFIG_MPTCP_BINDER=y\
        CONFIG_DEFAULT_FULLMESH=y\
        CONFIG_DEFAULT_NDIFFPORTS\
        CONFIG_DEFAULT_BINDER\
        CONFIG_DEFAULT_DUMMY\
        CONFIG_MPTCP_SCHED_ADVANCED=y\
        CONFIG_MPTCP_ROUNDROBIN=y\
        CONFIG_MPTCP_REDUNDANT=y\
        CONFIG_DEFAULT_SCHEDULER\
        CONFIG_DEFAULT_ROUNDROBIN\
        CONFIG_DEFAULT_REDUNDANT=y\
        CONFIG_TCP_CONG_LIA=y\
        CONFIG_TCP_CONG_OLIA=y\
        CONFIG_TCP_CONG_WVEGAS=y\
        CONFIG_TCP_CONG_BALIA=y\
        CONFIG_DEFAULT_BALIA=y

define Build/Clean
        rm -rf $(BUILD_DIR)/$(PKG_NAME)/
endef

$(eval $(call KernelPackage,mptcp))
