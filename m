Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32953 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbdHBIfM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 2 Aug 2017 04:35:12 -0400
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] rtc: add const to bin_attribute structures
Date: Wed,  2 Aug 2017 14:05:02 +0530
Message-Id: <1501662902-16048-1-git-send-email-bhumirks@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Add const to bin_attribute structures as they are only passed to the
functions sysfs_{remove/create}_bin_file or
device_{remove/create}_bin_file. The arguments passed are of
type const, so declare the structures to be const.

Done using Coccinelle:

@m disable optional_qualifier@
identifier s;
position p;
@@
static struct bin_attribute s@p={...};

@okay1@
position p;
identifier m.s;
@@
(
sysfs_create_bin_file(...,&s@p,...)
|
sysfs_remove_bin_file(...,&s@p,...)
)

@bad@
position p!={m.p,okay1.p};
identifier m.s;
@@
s@p

@change depends on !bad disable optional_qualifier@
identifier m.s;
@@
static
+const
struct bin_attribute s={...};

Same script was modified for device_{create/remove}_bin_file functions.
Cross compiled drivers/rtc/rtc-tx4939.o file for mips architecture.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/rtc/rtc-ds1305.c   | 2 +-
 drivers/rtc/rtc-ds1343.c   | 2 +-
 drivers/rtc/rtc-stk17ta8.c | 2 +-
 drivers/rtc/rtc-tx4939.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index 72b2293..148e746 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -558,7 +558,7 @@ static void msg_init(struct spi_message *m, struct spi_transfer *x,
 	return (status < 0) ? status : count;
 }
 
-static struct bin_attribute nvram = {
+static const struct bin_attribute nvram = {
 	.attr.name	= "nvram",
 	.attr.mode	= S_IRUGO | S_IWUSR,
 	.read		= ds1305_nvram_read,
diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index 895fbee..61d4254 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -191,7 +191,7 @@ static ssize_t ds1343_nvram_read(struct file *filp, struct kobject *kobj,
 }
 
 
-static struct bin_attribute nvram_attr = {
+static const struct bin_attribute nvram_attr = {
 	.attr.name	= "nvram",
 	.attr.mode	= S_IRUGO | S_IWUSR,
 	.read		= ds1343_nvram_read,
diff --git a/drivers/rtc/rtc-stk17ta8.c b/drivers/rtc/rtc-stk17ta8.c
index a456cb6..b84c83a 100644
--- a/drivers/rtc/rtc-stk17ta8.c
+++ b/drivers/rtc/rtc-stk17ta8.c
@@ -272,7 +272,7 @@ static ssize_t stk17ta8_nvram_write(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static struct bin_attribute stk17ta8_nvram_attr = {
+static const struct bin_attribute stk17ta8_nvram_attr = {
 	.attr = {
 		.name = "nvram",
 		.mode = S_IRUGO | S_IWUSR,
diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index 560d9a5..83fbfa5a 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -225,7 +225,7 @@ static ssize_t tx4939_rtc_nvram_write(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static struct bin_attribute tx4939_rtc_nvram_attr = {
+static const struct bin_attribute tx4939_rtc_nvram_attr = {
 	.attr = {
 		.name = "nvram",
 		.mode = S_IRUGO | S_IWUSR,
-- 
1.9.1
