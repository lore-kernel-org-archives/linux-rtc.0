Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:52835 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdJKVgT (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 11 Oct 2017 17:36:19 -0400
Received: by mail-pf0-f175.google.com with SMTP id e64so2131824pfk.9
        for <linux-rtc@vger.kernel.org>; Wed, 11 Oct 2017 14:36:18 -0700 (PDT)
From: Eric Nelson <eric@nelint.com>
To: linux-rtc@vger.kernel.org
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, otavio.salvador@ossystems.com.br,
        peng.fan@nxp.com, Eric Nelson <eric@nelint.com>
Subject: [PATCH V2] imx: mx7dsabresd: include BLK for MMC/eMMC support of driver model
Date: Wed, 11 Oct 2017 14:34:14 -0700
Message-Id: <1507757654-22114-1-git-send-email-eric@nelint.com>
In-Reply-To: <1507753798-20666-1-git-send-email-eric@nelint.com>
References: <1507753798-20666-1-git-send-email-eric@nelint.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Commit 6fbbcfd introduced device-tree support for MMC devices on
the mx7sabresd boards and didn't include BLK, which requires BLK.

Commit 8ae5bb3 did the same for secure boot.

Fix both by allowing blk-uclass (BLK) support.

Tested-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Eric Nelson <eric@nelint.com>
---
V2 includes the updated to mx7dsabresd_secure_defconfig
 configs/mx7dsabresd_defconfig        | 1 -
 configs/mx7dsabresd_secure_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/mx7dsabresd_defconfig b/configs/mx7dsabresd_defconfig
index 795c4f2..144fb50 100644
--- a/configs/mx7dsabresd_defconfig
+++ b/configs/mx7dsabresd_defconfig
@@ -38,7 +38,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
-# CONFIG_BLK is not set
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DM_GPIO=y
diff --git a/configs/mx7dsabresd_secure_defconfig b/configs/mx7dsabresd_secure_defconfig
index bd68831..d1af138 100644
--- a/configs/mx7dsabresd_secure_defconfig
+++ b/configs/mx7dsabresd_secure_defconfig
@@ -40,7 +40,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
-# CONFIG_BLK is not set
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DM_GPIO=y
-- 
2.7.4
