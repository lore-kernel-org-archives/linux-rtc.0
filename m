Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F733AAF67
	for <linux-rtc@vger.kernel.org>; Fri,  7 Aug 2026 01:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066779; cv=none; b=jryzSiq8YW9ZWUj3T+W3HUwyzP4/DtcJhHTzOs5hm6Jucm6dWyb+BvwUF1coI5Mxl6LE7j4NHstfeZbfGNFNyUTudSeRZxvCH9GHDutjgMsJITVragLCxI//XGAb17XlCQl9tuhBNArZQZ27dKUW9u4ljkuDigpAhM3+YjH2NXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066779; c=relaxed/simple;
	bh=xT5df2hXdZFwFE84GYU7rXCNIyIk1DgLgbS0XxbI4sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FxzpbY+jducSNxqsUCRK5HKTc9gdo8w1xJTNsKbcSZ87T4pJ+KUcJHdUrchcXzEsE8E6aYNfC8ad9STXe58r7QSclyg0nUtpxPU+0FwMHjlREndSEN2ac0ukI/ZlyweeBpKnCNzffHH13zoxNZsveRvRAgznPltHtbyZ5uB55do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gn/aGCvr; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn/aGCvr"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-936623c6dd3so63869185a.0
        for <linux-rtc@vger.kernel.org>; Thu, 06 Aug 2026 18:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786066767; x=1786671567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h18V7+yMAxWfYR5Cuy7tE5IJl+PiABLw6nhOIkxnOes=;
        b=Gn/aGCvrg+QDQAwtDhwxAGHkqk5oMKbSJICj0POCvi/Pn8oAPc8mEXgNlXfFVnUdIX
         BRiJSrs21f635fD7EcFwIG2psEL+VghXxKx5uMpIRkSC/9sr9x9EOIh6ney2mTm056ER
         wlym5nvcDPXWIM2zozE+2z3jgOFdeLoLm8LlRq5HBxc9vPIxhDX3vGWiuBuCxcOR6i2L
         cUI4671MR26T8kIGgDpVFREfgbq0yxiDp1Ua9Aeokebz1MCQkPMdGpMmbyjMY7QNjzj2
         O/sIdeeT0Ii9SpbWPFJa7G4UsRjXZjCGQZoIvTa0Yzji0Uw4ABF0md95H/VtAtaBOuaJ
         8Pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786066767; x=1786671567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h18V7+yMAxWfYR5Cuy7tE5IJl+PiABLw6nhOIkxnOes=;
        b=dZGpJnYjeGB09h7cFxX+t30vIxgG1t2cJ48JkSzn2ZK7BhVnF8B6He7Q19eXTTRvzE
         7o1M7v20TCT8zcwDbPm1nYJ6EuSP390XpaOeYIJNk23bzaJGgWCB5lJPAMaPqenbmz1E
         BTCumm04SquUHdCyTY+e52wmJPRB81ybnBIT31tUe79ymVyem2L/wv9U+EkazOYmwXpN
         hcT2cqHXfBR7T3TLe/xPH50lxyV8+KoTu6hTIzFXfs0imrP+8o7r7s+bVD87BPiReeC8
         tf9dmyN6BVm+fTdNnsGh6ALi1j+gVRZa6QEusVNyJqBUgxko3IMtDLBhnnhHjnaxxODU
         o6uA==
X-Gm-Message-State: AOJu0YwvguC2cuJQy7WEd+emJLqMB/1ATtEMTwO+G4u5VDmVqN7vEQAq
	Rj//CElmwixPt8UKRD1nU+5UZ//RxPfMwue+MjpbHv3yy+h72ciCWQZ5TZl6pVcH/TI=
X-Gm-Gg: AR+sD10qw5ezBq6lJ7phGLBRT+Q67etTTWGbBilSoCXU6MMpgEDSxwTzVS6M17iKtc6
	XEZ8pqiaTr7vl2/Aad2p7aL+ZUbqCjNRB1G3gxG0Ph8Hr6zWV+j3NAB3Wc0FN5GXrLEmQGmL9Vs
	c1Kv1jTnyc3c+PLCDUY4bLVvo5W6K3au7rjEFO1E5uWf1j3551tgh/DILWmWjvqoLtkhn1KJrBT
	HmWNgsbLIJPVlxAgq/L0kGiF3eBP9lVH+88LAgtsrFo6fP6jm0GioKaMJ+NzbWkhT0zUxtU1QPj
	enBzWocaUiLYbHPw9ZsJP1mb5uIVq/vFze7st66jrkXowRk2X7I/LmXNtp755kM2xVUkrBIG+q4
	mavGaEJibVoDeBYmaVl0wOyrhm1tB2DuXsI80Nml1CCXuLsUExln+x5HmZ2TvjOUaAR4D/p7ZJq
	iaCB/oPtYHNv3yvpINpagBB8B5GLMGNRKkivwUr+A28vDIB/55F6JsV4jFIcj03T/m8RfYk8Tt9
	B4Iy1e2GpcJBknC0jOrTenmbuekrEGzOE3TIpN8jfm38tDFA4wqfqPqDUCOq6v1nwM5Vzuv8w==
X-Received: by 2002:a05:620a:4485:b0:934:826c:b066 with SMTP id af79cd13be357-9365959e187mr1098954885a.11.1786066766904;
        Thu, 06 Aug 2026 18:39:26 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e03230esm44591685a.5.2026.08.06.18.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 18:39:25 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v2] rtc: m41t80: use watchdog core for watchdog support
Date: Thu,  6 Aug 2026 21:39:15 -0400
Message-ID: <20260807013915.907604-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The M41T80 watchdog uses a global misc device, reboot notifier, and
save_client pointer. If probe fails after those objects are registered,
probe failure skips the remove callback while devres releases the driver
state. Later watchdog or reboot callbacks can then access stale driver
state. The same global lifetime does not safely cover an open watchdog
file during device removal.

Use the watchdog core with a watchdog device embedded in m41t80_data.
The devm registration is undone automatically on probe failure and device
removal, while watchdog_stop_on_reboot() replaces the driver-specific
reboot notifier. watchdog_set_drvdata() also keeps watchdog operations
bound to the owning device instead of a global client pointer.

Remove the legacy misc device, notifier, and remove callback, and enable
the watchdog core for the optional watchdog configuration.

Fixes: 10d0c768cc6d ("rtc: m41t80: fix race conditions")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
Changes in v2:
- Reworked the fix to use the watchdog core instead of adding a
  probe-failure cleanup path.
- Replaced the global pointer with a per-device watchdog_device
  registered through devm_watchdog_register_device().
- Added watchdog core Kconfig dependencies.
 drivers/rtc/Kconfig      |   3 +-
 drivers/rtc/rtc-m41t80.c | 331 ++++++++++-----------------------------
 2 files changed, 86 insertions(+), 248 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 01def8231873..2f3e964208eb 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -561,7 +561,8 @@ config RTC_DRV_M41T80
 
 config RTC_DRV_M41T80_WDT
 	bool "ST M41T65/M41T80 series RTC watchdog timer"
-	depends on RTC_DRV_M41T80
+	depends on RTC_DRV_M41T80 && WATCHDOG
+	select WATCHDOG_CORE
 	help
 	  If you say Y here you will get support for the
 	  watchdog timer in the ST M41T60 and M41T80 RTC chips series.
diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 3c8c379392c1..ec2238d9170e 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -24,10 +24,6 @@
 #include <linux/string.h>
 #include <linux/delay.h>
 #ifdef CONFIG_RTC_DRV_M41T80_WDT
-#include <linux/fs.h>
-#include <linux/ioctl.h>
-#include <linux/miscdevice.h>
-#include <linux/reboot.h>
 #include <linux/watchdog.h>
 #endif
 
@@ -148,6 +144,9 @@ struct m41t80_data {
 	unsigned long features;
 	struct i2c_client *client;
 	struct rtc_device *rtc;
+#ifdef CONFIG_RTC_DRV_M41T80_WDT
+	struct watchdog_device wdt;
+#endif
 #ifdef CONFIG_COMMON_CLK
 	struct clk_hw sqw;
 	unsigned long freq;
@@ -626,273 +625,118 @@ static struct clk *m41t80_sqw_register_clk(struct m41t80_data *m41t80)
  *
  *****************************************************************************
  */
-static DEFINE_MUTEX(m41t80_rtc_mutex);
-static struct i2c_client *save_client;
-
 /* Default margin */
-#define WD_TIMO 60		/* 1..31 seconds */
+#define M41T80_WDT_DEFAULT_TIMEOUT	60
+#define M41T80_WDT_MIN_TIMEOUT	1
+#define M41T80_WDT_MAX_TIMEOUT	124
 
-static int wdt_margin = WD_TIMO;
+static int wdt_margin = M41T80_WDT_DEFAULT_TIMEOUT;
 module_param(wdt_margin, int, 0);
 MODULE_PARM_DESC(wdt_margin, "Watchdog timeout in seconds (default 60s)");
 
-static unsigned long wdt_is_open;
-static int boot_flag;
+static const struct watchdog_info m41t80_wdt_info = {
+	.options = WDIOF_POWERUNDER | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+	.firmware_version = 1,
+	.identity = "M41T80 Watchdog",
+};
 
 /**
- *	wdt_ping - Reload counter one with the watchdog timeout.
- *	We don't bother reloading the cascade counter.
+ * m41t80_wdt_ping - Reload the watchdog counter.
  */
-static void wdt_ping(void)
+static int m41t80_wdt_ping(struct watchdog_device *wdt)
 {
+	struct m41t80_data *m41t80 = watchdog_get_drvdata(wdt);
+	struct i2c_client *client = m41t80->client;
 	unsigned char i2c_data[2];
-	struct i2c_msg msgs1[1] = {
-		{
-			.addr	= save_client->addr,
-			.flags	= 0,
-			.len	= 2,
-			.buf	= i2c_data,
-		},
+	struct i2c_msg msg = {
+		.addr = client->addr,
+		.flags = 0,
+		.len = 2,
+		.buf = i2c_data,
 	};
-	struct m41t80_data *clientdata = i2c_get_clientdata(save_client);
+	int ret;
 
-	i2c_data[0] = 0x09;		/* watchdog register */
+	i2c_data[0] = 0x09; /* watchdog register */
 
-	if (wdt_margin > 31)
-		i2c_data[1] = (wdt_margin & 0xFC) | 0x83; /* resolution = 4s */
+	if (wdt->timeout > 31)
+		i2c_data[1] = (wdt->timeout & 0xFC) | 0x83;
 	else
 		/*
-		 * WDS = 1 (0x80), mulitplier = WD_TIMO, resolution = 1s (0x02)
+		 * WDS = 1 (0x80), multiplier = timeout, resolution = 1s (0x02)
 		 */
-		i2c_data[1] = wdt_margin << 2 | 0x82;
+		i2c_data[1] = wdt->timeout << 2 | 0x82;
 
 	/*
-	 * M41T65 has three bits for watchdog resolution.  Don't set bit 7, as
+	 * M41T65 has three bits for watchdog resolution. Don't set bit 7, as
 	 * that would be an invalid resolution.
 	 */
-	if (clientdata->features & M41T80_FEATURE_WD)
+	if (m41t80->features & M41T80_FEATURE_WD)
 		i2c_data[1] &= ~M41T80_WATCHDOG_RB2;
 
-	i2c_transfer(save_client->adapter, msgs1, 1);
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret == 1)
+		return 0;
+
+	return ret < 0 ? ret : -EIO;
 }
 
 /**
- *	wdt_disable - disables watchdog.
+ * m41t80_wdt_stop - Disable the watchdog.
  */
-static void wdt_disable(void)
+static int m41t80_wdt_stop(struct watchdog_device *wdt)
 {
+	struct m41t80_data *m41t80 = watchdog_get_drvdata(wdt);
+	struct i2c_client *client = m41t80->client;
 	unsigned char i2c_data[2], i2c_buf[0x10];
 	struct i2c_msg msgs0[2] = {
 		{
-			.addr	= save_client->addr,
-			.flags	= 0,
-			.len	= 1,
-			.buf	= i2c_data,
+			.addr = client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = i2c_data,
 		},
 		{
-			.addr	= save_client->addr,
-			.flags	= I2C_M_RD,
-			.len	= 1,
-			.buf	= i2c_buf,
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = 1,
+			.buf = i2c_buf,
 		},
 	};
-	struct i2c_msg msgs1[1] = {
-		{
-			.addr	= save_client->addr,
-			.flags	= 0,
-			.len	= 2,
-			.buf	= i2c_data,
-		},
+	struct i2c_msg msg = {
+		.addr = client->addr,
+		.flags = 0,
+		.len = 2,
+		.buf = i2c_data,
 	};
+	int ret;
 
 	i2c_data[0] = 0x09;
-	i2c_transfer(save_client->adapter, msgs0, 2);
+	ret = i2c_transfer(client->adapter, msgs0, 2);
+	if (ret != 2)
+		return ret < 0 ? ret : -EIO;
 
 	i2c_data[0] = 0x09;
 	i2c_data[1] = 0x00;
-	i2c_transfer(save_client->adapter, msgs1, 1);
-}
-
-/**
- *	wdt_write - write to watchdog.
- *	@file: file handle to the watchdog
- *	@buf: buffer to write (unused as data does not matter here
- *	@count: count of bytes
- *	@ppos: pointer to the position to write. No seeks allowed
- *
- *	A write to a watchdog device is defined as a keepalive signal. Any
- *	write of data will do, as we don't define content meaning.
- */
-static ssize_t wdt_write(struct file *file, const char __user *buf,
-			 size_t count, loff_t *ppos)
-{
-	if (count) {
-		wdt_ping();
-		return 1;
-	}
-	return 0;
-}
-
-static ssize_t wdt_read(struct file *file, char __user *buf,
-			size_t count, loff_t *ppos)
-{
-	return 0;
-}
-
-/**
- *	wdt_ioctl - ioctl handler to set watchdog.
- *	@file: file handle to the device
- *	@cmd: watchdog command
- *	@arg: argument pointer
- *
- *	The watchdog API defines a common set of functions for all watchdogs
- *	according to their available features. We only actually usefully support
- *	querying capabilities and current status.
- */
-static int wdt_ioctl(struct file *file, unsigned int cmd,
-		     unsigned long arg)
-{
-	int new_margin, rv;
-	static struct watchdog_info ident = {
-		.options = WDIOF_POWERUNDER | WDIOF_KEEPALIVEPING |
-			WDIOF_SETTIMEOUT,
-		.firmware_version = 1,
-		.identity = "M41T80 WTD"
-	};
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		return copy_to_user((struct watchdog_info __user *)arg, &ident,
-				    sizeof(ident)) ? -EFAULT : 0;
-
-	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
-		return put_user(boot_flag, (int __user *)arg);
-	case WDIOC_KEEPALIVE:
-		wdt_ping();
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret == 1)
 		return 0;
-	case WDIOC_SETTIMEOUT:
-		if (get_user(new_margin, (int __user *)arg))
-			return -EFAULT;
-		/* Arbitrary, can't find the card's limits */
-		if (new_margin < 1 || new_margin > 124)
-			return -EINVAL;
-		wdt_margin = new_margin;
-		wdt_ping();
-		fallthrough;
-	case WDIOC_GETTIMEOUT:
-		return put_user(wdt_margin, (int __user *)arg);
-
-	case WDIOC_SETOPTIONS:
-		if (copy_from_user(&rv, (int __user *)arg, sizeof(int)))
-			return -EFAULT;
-
-		if (rv & WDIOS_DISABLECARD) {
-			pr_info("disable watchdog\n");
-			wdt_disable();
-		}
-
-		if (rv & WDIOS_ENABLECARD) {
-			pr_info("enable watchdog\n");
-			wdt_ping();
-		}
 
-		return -EINVAL;
-	}
-	return -ENOTTY;
+	return ret < 0 ? ret : -EIO;
 }
 
-static long wdt_unlocked_ioctl(struct file *file, unsigned int cmd,
-			       unsigned long arg)
+static int m41t80_wdt_set_timeout(struct watchdog_device *wdt, unsigned int timeout)
 {
-	int ret;
+	wdt->timeout = timeout;
 
-	mutex_lock(&m41t80_rtc_mutex);
-	ret = wdt_ioctl(file, cmd, arg);
-	mutex_unlock(&m41t80_rtc_mutex);
-
-	return ret;
+	return m41t80_wdt_ping(wdt);
 }
 
-/**
- *	wdt_open - open a watchdog.
- *	@inode: inode of device
- *	@file: file handle to device
- *
- */
-static int wdt_open(struct inode *inode, struct file *file)
-{
-	if (iminor(inode) == WATCHDOG_MINOR) {
-		mutex_lock(&m41t80_rtc_mutex);
-		if (test_and_set_bit(0, &wdt_is_open)) {
-			mutex_unlock(&m41t80_rtc_mutex);
-			return -EBUSY;
-		}
-		/*
-		 *	Activate
-		 */
-		wdt_is_open = 1;
-		mutex_unlock(&m41t80_rtc_mutex);
-		return stream_open(inode, file);
-	}
-	return -ENODEV;
-}
-
-/**
- *	wdt_release - release a watchdog.
- *	@inode: inode to board
- *	@file: file handle to board
- *
- */
-static int wdt_release(struct inode *inode, struct file *file)
-{
-	if (iminor(inode) == WATCHDOG_MINOR)
-		clear_bit(0, &wdt_is_open);
-	return 0;
-}
-
-/**
- *	wdt_notify_sys - notify to watchdog.
- *	@this: our notifier block
- *	@code: the event being reported
- *	@unused: unused
- *
- *	Our notifier is called on system shutdowns. We want to turn the card
- *	off at reboot otherwise the machine will reboot again during memory
- *	test or worse yet during the following fsck. This would suck, in fact
- *	trust me - if it happens it does suck.
- */
-static int wdt_notify_sys(struct notifier_block *this, unsigned long code,
-			  void *unused)
-{
-	if (code == SYS_DOWN || code == SYS_HALT)
-		/* Disable Watchdog */
-		wdt_disable();
-	return NOTIFY_DONE;
-}
-
-static const struct file_operations wdt_fops = {
-	.owner	= THIS_MODULE,
-	.read	= wdt_read,
-	.unlocked_ioctl = wdt_unlocked_ioctl,
-	.compat_ioctl = compat_ptr_ioctl,
-	.write	= wdt_write,
-	.open	= wdt_open,
-	.release = wdt_release,
-};
-
-static struct miscdevice wdt_dev = {
-	.minor = WATCHDOG_MINOR,
-	.name = "watchdog",
-	.fops = &wdt_fops,
-};
-
-/*
- *	The WDT card needs to learn about soft shutdowns in order to
- *	turn the timebomb registers off.
- */
-static struct notifier_block wdt_notifier = {
-	.notifier_call = wdt_notify_sys,
+static const struct watchdog_ops m41t80_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = m41t80_wdt_ping,
+	.stop = m41t80_wdt_stop,
+	.ping = m41t80_wdt_ping,
+	.set_timeout = m41t80_wdt_set_timeout,
 };
 #endif /* CONFIG_RTC_DRV_M41T80_WDT */
 
@@ -989,19 +833,6 @@ static int m41t80_probe(struct i2c_client *client)
 		return rc;
 	}
 
-#ifdef CONFIG_RTC_DRV_M41T80_WDT
-	if (m41t80_data->features & M41T80_FEATURE_HT) {
-		save_client = client;
-		rc = misc_register(&wdt_dev);
-		if (rc)
-			return rc;
-		rc = register_reboot_notifier(&wdt_notifier);
-		if (rc) {
-			misc_deregister(&wdt_dev);
-			return rc;
-		}
-	}
-#endif
 #ifdef CONFIG_COMMON_CLK
 	if (m41t80_data->features & M41T80_FEATURE_SQ)
 		m41t80_sqw_register_clk(m41t80_data);
@@ -1011,19 +842,26 @@ static int m41t80_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
-	return 0;
-}
-
-static void m41t80_remove(struct i2c_client *client)
-{
 #ifdef CONFIG_RTC_DRV_M41T80_WDT
-	struct m41t80_data *clientdata = i2c_get_clientdata(client);
-
-	if (clientdata->features & M41T80_FEATURE_HT) {
-		misc_deregister(&wdt_dev);
-		unregister_reboot_notifier(&wdt_notifier);
+	if (m41t80_data->features & M41T80_FEATURE_HT) {
+		m41t80_data->wdt.info = &m41t80_wdt_info;
+		m41t80_data->wdt.ops = &m41t80_wdt_ops;
+		m41t80_data->wdt.timeout = M41T80_WDT_DEFAULT_TIMEOUT;
+		m41t80_data->wdt.min_timeout = M41T80_WDT_MIN_TIMEOUT;
+		m41t80_data->wdt.max_timeout = M41T80_WDT_MAX_TIMEOUT;
+
+		watchdog_init_timeout(&m41t80_data->wdt, wdt_margin, &client->dev);
+		watchdog_stop_on_reboot(&m41t80_data->wdt);
+		watchdog_stop_on_unregister(&m41t80_data->wdt);
+		watchdog_set_drvdata(&m41t80_data->wdt, m41t80_data);
+
+		rc = devm_watchdog_register_device(&client->dev, &m41t80_data->wdt);
+		if (rc)
+			return rc;
 	}
 #endif
+
+	return 0;
 }
 
 static struct i2c_driver m41t80_driver = {
@@ -1033,7 +871,6 @@ static struct i2c_driver m41t80_driver = {
 		.pm = &m41t80_pm,
 	},
 	.probe = m41t80_probe,
-	.remove = m41t80_remove,
 	.id_table = m41t80_id,
 };
 
-- 
2.43.0

