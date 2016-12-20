Return-Path: <rtc-linux+bncBAABBDO64PBAKGQE4DN7ZQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [2a00:1098:0:82:1000:25:2eeb:e3e3])
        by gmr-mx.google.com with ESMTPS id o77si1598370wme.0.2016.12.20.00.42.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Dec 2016 00:42:53 -0800 (PST)
From: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
To: alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it
Cc: rtc-linux@googlegroups.com,
	Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Subject: [rtc-linux] [PATCH v2 1/1] rtc: rx8010: change lock mechanism
Date: Tue, 20 Dec 2016 09:42:44 +0100
Message-Id: <1482223364-25427-1-git-send-email-fabien.lahoudere@collabora.co.uk>
In-Reply-To: <20161219001734.ghsir573a45ksuxv@piout.net>
References: <20161219001734.ghsir573a45ksuxv@piout.net>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Remove spinlock and use the "rtc->ops_lock" from RTC subsystem instead.
spin_lock_irqsave() is not needed here because we do not have hard IRQs.

This patch fixes the following issue:

root@GE004097290448 b850v3:~# hwclock --systohc
root@GE004097290448 b850v3:~# hwclock --systohc
root@GE004097290448 b850v3:~# hwclock --systohc
root@GE004097290448 b850v3:~# hwclock --systohc
root@GE004097290448 b850v3:~# hwclock --systohc
[   82.108175] BUG: spinlock wrong CPU on CPU#0, hwclock/855
[   82.113660]  lock: 0xedb4899c, .magic: dead4ead, .owner: hwclock/855, .owner_cpu: 1
[   82.121329] CPU: 0 PID: 855 Comm: hwclock Not tainted 4.8.0-00042-g09d5410-dirty #20
[   82.129078] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   82.135609] Backtrace:
[   82.138090] [<8010d378>] (dump_backtrace) from [<8010d5c0>] (show_stack+0x20/0x24)
[   82.145664]  r7:ec936000 r6:600a0013 r5:00000000 r4:81031680
[   82.151402] [<8010d5a0>] (show_stack) from [<80401518>] (dump_stack+0xb4/0xe8)
[   82.158636] [<80401464>] (dump_stack) from [<8017b8b0>] (spin_dump+0x84/0xcc)
[   82.165775]  r10:00000000 r9:ec936000 r8:81056090 r7:600a0013 r6:edb4899c r5:edb4899c
[   82.173691]  r4:e5033e00 r3:00000000
[   82.177308] [<8017b82c>] (spin_dump) from [<8017bcb0>] (do_raw_spin_unlock+0x108/0x130)
[   82.185314]  r5:edb4899c r4:edb4899c
[   82.188938] [<8017bba8>] (do_raw_spin_unlock) from [<8094b93c>] (_raw_spin_unlock_irqrestore+0x34/0x54)
[   82.198333]  r5:edb4899c r4:600a0013
[   82.201953] [<8094b908>] (_raw_spin_unlock_irqrestore) from [<8065b090>] (rx8010_set_time+0x14c/0x188)
[   82.211261]  r5:00000020 r4:edb48990
[   82.214882] [<8065af44>] (rx8010_set_time) from [<80653fe4>] (rtc_set_time+0x70/0x104)
[   82.222801]  r7:00000051 r6:edb39da0 r5:edb39c00 r4:ec937e8c
[   82.228535] [<80653f74>] (rtc_set_time) from [<80655774>] (rtc_dev_ioctl+0x3c4/0x674)
[   82.236368]  r7:00000051 r6:7ecf1b74 r5:00000000 r4:edb39c00
[   82.242106] [<806553b0>] (rtc_dev_ioctl) from [<80284034>] (do_vfs_ioctl+0xa4/0xa6c)
[   82.249851]  r8:00000003 r7:80284a40 r6:ed1e9c80 r5:edb44e60 r4:7ecf1b74
[   82.256642] [<80283f90>] (do_vfs_ioctl) from [<80284a40>] (SyS_ioctl+0x44/0x6c)
[   82.263953]  r10:00000000 r9:ec936000 r8:7ecf1b74 r7:4024700a r6:ed1e9c80 r5:00000003
[   82.271869]  r4:ed1e9c80
[   82.274432] [<802849fc>] (SyS_ioctl) from [<80108520>] (ret_fast_syscall+0x0/0x1c)
[   82.282005]  r9:ec936000 r8:801086c4 r7:00000036 r6:00000000 r5:00000003 r4:0008e1bc
root@GE004097290448 b850v3:~#
Message from syslogd@GE004097290448 at Dec  3 11:17:08 ...
 kernel:[   82.108175] BUG: spinlock wrong CPU on CPU#0, hwclock/855

Message from syslogd@GE004097290448 at Dec  3 11:17:08 ...
 kernel:[   82.113660]  lock: 0xedb4899c, .magic: dead4ead, .owner: hwclock/855, .owner_cpu: 1
hwclock --systohc
root@GE004097290448 b850v3:~#

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
---
 drivers/rtc/rtc-rx8010.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 7163b91..d08da37 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -63,7 +63,6 @@ struct rx8010_data {
 	struct i2c_client *client;
 	struct rtc_device *rtc;
 	u8 ctrlreg;
-	spinlock_t flags_lock;
 };
 
 static irqreturn_t rx8010_irq_1_handler(int irq, void *dev_id)
@@ -72,12 +71,12 @@ static irqreturn_t rx8010_irq_1_handler(int irq, void *dev_id)
 	struct rx8010_data *rx8010 = i2c_get_clientdata(client);
 	int flagreg;
 
-	spin_lock(&rx8010->flags_lock);
+	mutex_lock(&rx8010->rtc->ops_lock);
 
 	flagreg = i2c_smbus_read_byte_data(client, RX8010_FLAG);
 
 	if (flagreg <= 0) {
-		spin_unlock(&rx8010->flags_lock);
+		mutex_unlock(&rx8010->rtc->ops_lock);
 		return IRQ_NONE;
 	}
 
@@ -101,7 +100,7 @@ static irqreturn_t rx8010_irq_1_handler(int irq, void *dev_id)
 
 	i2c_smbus_write_byte_data(client, RX8010_FLAG, flagreg);
 
-	spin_unlock(&rx8010->flags_lock);
+	mutex_unlock(&rx8010->rtc->ops_lock);
 	return IRQ_HANDLED;
 }
 
@@ -143,7 +142,6 @@ static int rx8010_set_time(struct device *dev, struct rtc_time *dt)
 	u8 date[7];
 	int ctrl, flagreg;
 	int ret;
-	unsigned long irqflags;
 
 	if ((dt->tm_year < 100) || (dt->tm_year > 199))
 		return -EINVAL;
@@ -181,11 +179,8 @@ static int rx8010_set_time(struct device *dev, struct rtc_time *dt)
 	if (ret < 0)
 		return ret;
 
-	spin_lock_irqsave(&rx8010->flags_lock, irqflags);
-
 	flagreg = i2c_smbus_read_byte_data(rx8010->client, RX8010_FLAG);
 	if (flagreg < 0) {
-		spin_unlock_irqrestore(&rx8010->flags_lock, irqflags);
 		return flagreg;
 	}
 
@@ -193,8 +188,6 @@ static int rx8010_set_time(struct device *dev, struct rtc_time *dt)
 		ret = i2c_smbus_write_byte_data(rx8010->client, RX8010_FLAG,
 						flagreg & ~RX8010_FLAG_VLF);
 
-	spin_unlock_irqrestore(&rx8010->flags_lock, irqflags);
-
 	return 0;
 }
 
@@ -288,12 +281,9 @@ static int rx8010_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	u8 alarmvals[3];
 	int extreg, flagreg;
 	int err;
-	unsigned long irqflags;
 
-	spin_lock_irqsave(&rx8010->flags_lock, irqflags);
 	flagreg = i2c_smbus_read_byte_data(client, RX8010_FLAG);
 	if (flagreg < 0) {
-		spin_unlock_irqrestore(&rx8010->flags_lock, irqflags);
 		return flagreg;
 	}
 
@@ -302,14 +292,12 @@ static int rx8010_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 		err = i2c_smbus_write_byte_data(rx8010->client, RX8010_CTRL,
 						rx8010->ctrlreg);
 		if (err < 0) {
-			spin_unlock_irqrestore(&rx8010->flags_lock, irqflags);
 			return err;
 		}
 	}
 
 	flagreg &= ~RX8010_FLAG_AF;
 	err = i2c_smbus_write_byte_data(rx8010->client, RX8010_FLAG, flagreg);
-	spin_unlock_irqrestore(&rx8010->flags_lock, irqflags);
 	if (err < 0)
 		return err;
 
@@ -404,7 +392,6 @@ static int rx8010_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 	struct rx8010_data *rx8010 = dev_get_drvdata(dev);
 	int ret, tmp;
 	int flagreg;
-	unsigned long irqflags;
 
 	switch (cmd) {
 	case RTC_VL_READ:
@@ -419,16 +406,13 @@ static int rx8010_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 		return 0;
 
 	case RTC_VL_CLR:
-		spin_lock_irqsave(&rx8010->flags_lock, irqflags);
 		flagreg = i2c_smbus_read_byte_data(rx8010->client, RX8010_FLAG);
 		if (flagreg < 0) {
-			spin_unlock_irqrestore(&rx8010->flags_lock, irqflags);
 			return flagreg;
 		}
 
 		flagreg &= ~RX8010_FLAG_VLF;
 		ret = i2c_smbus_write_byte_data(client, RX8010_FLAG, flagreg);
-		spin_unlock_irqrestore(&rx8010->flags_lock, irqflags);
 		if (ret < 0)
 			return ret;
 
@@ -466,8 +450,6 @@ static int rx8010_probe(struct i2c_client *client,
 	rx8010->client = client;
 	i2c_set_clientdata(client, rx8010);
 
-	spin_lock_init(&rx8010->flags_lock);
-
 	err = rx8010_init_client(client);
 	if (err)
 		return err;
-- 
1.8.3.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
