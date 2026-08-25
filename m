Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5B9387359
	for <linux-rtc@vger.kernel.org>; Tue, 25 Aug 2026 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787692064; cv=none; b=vBFh4WuHlg31nXTt3XJyc2w1hDK/ybYkzSFVRVZ5XGC+9hYmgJuqswFJI3q+Ip9uKn4BIQo7sRRGrVb5xemC9iky/mlENSiUN8rjznlA5j47y7ZrlpdcQJRp2PDfUXSurfQueZdzcHs/TZSoVDfnSOLcdLW2wsQltZ6ZOWRMThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787692064; c=relaxed/simple;
	bh=IhnnVWDYYFxJJZfBWcFAlyCWw8xy9QcXYHNO6upP9ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apFLOQ+qzPM504MCkDVZQGZiXjlBD3MlqGjMVsZ0g4OVdCiItaE8Ywz7RzM6/IyVFpPDRo5vmyFoH6UreIaxHN/pD1kf81GhOk1OQq12P8wJuh8p7kg7o2NprnkKgw49mhbuNb8uxX2aidlSXTjtblAUBfjqAzcgdMLDvIzPjx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FrkI1YRm; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FrkI1YRm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 205F94E413B2;
	Tue, 25 Aug 2026 21:07:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D137F604C4;
	Tue, 25 Aug 2026 21:07:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C789A11C7A806;
	Tue, 25 Aug 2026 23:07:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787692054; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jVZHMDAXLrogXoO+LvxaZMG/rdPayNSs2X+MOCykLxA=;
	b=FrkI1YRmY8Mf80Cjrm9HQ/nW/93M07fDeeFglJ5C9N+yKGnCycvECi7SGphKtt8P1dsiQd
	cz/5FlD7zl1ZIo6I6yRo4vHQyBzeqGvHFs5AkmUoUKeH68bt6i/FzvWefKie9qFBjIS/6I
	TLTyUpdHTdDzieoU8Zb39AMoqbwZ6EMAZ6TQHX0QZRqg/QlyxHjWRFMmYk8mMQZbFASZrT
	JN/lsgLs2d/yHt63Z+nWhAxe7zSnHdcdip3dVBQWyX4+YDLDFf3A7HdMhqHek5hLvTXEmk
	g3YzlLtNLB51HCFEtaPFnrmB59UkdJ6SMT/K/E3q/6dQTdDPjKx7Q213PPLcGA==
Date: Tue, 25 Aug 2026 23:07:33 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: pcf85063: disable the clkout output by default
Message-ID: <202608252107336920b1e4@mail.local>
References: <20260824080801.709764-1-alexander.sverdlin@siemens.com>
 <20260824082456e0edd7c6@mail.local>
 <2ce03d3b4cd9cce8e32fe1fe1ffbea5760bf9ef3.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="B1kxVD8HOxRY8rij"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ce03d3b4cd9cce8e32fe1fe1ffbea5760bf9ef3.camel@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3

--B1kxVD8HOxRY8rij
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 24/08/2026 09:58:16+0000, Sverdlin, Alexander wrote:
> Hi Alexandre,
> 
> On Mon, 2026-08-24 at 10:24 +0200, Alexandre Belloni wrote:
> > > From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > > 
> > > The PCF85063 powers up with its CLKOUT pin driving the 32.768 kHz. While
> > > it's possible to request a specific default frequency in the DT via
> > > assigned-clocks/assigned-clock-rates on the RTC node itself, even without
> > > a real consumer referencing the clock, there is no such possibility to
> > > disable the clock output by default.
> > 
> > Are you sure about this? The CCF should disable the clock if it is not
> > used.
> 
> There is late_initcall_sync(clk_disable_unused) (marked __init), but for the
> clock providers registered later, say, via modules, there is no such mechanism.
> And I double-checked this putting some debug prints into the driver,
> nothing from struct clk_ops is being called without a consumer in DT.
> 

Right, so what about the patch attached which seems to work fine with my
rv3032.

> > > Therefore gate CLKOUT in the driver before registering the OF provider,
> > > mirroring the pcf8563 and hym8563 siblings which already force an off state
> > > at registration. Doing it before devm_of_clk_add_hw_provider() leaves the
> > > real consumers in the device tree free to re-enable the output afterwards,
> > > while an otherwise unused CLKOUT now stays off.
> > > 
> > > In practice it means that with CLKOUT disabled the RTC consumes around
> > > 250nA at 25°C and 6-10uA with CLKOUT enabled (5v Vdd). Which means days vs
> > > hours on a supercapacitor.
> > > 
> > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > > ---
> > >  drivers/rtc/rtc-pcf85063.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> > > index 01e209d88f5f3..0b6d8083b6456 100644
> > > --- a/drivers/rtc/rtc-pcf85063.c
> > > +++ b/drivers/rtc/rtc-pcf85063.c
> > > @@ -523,6 +523,12 @@ static struct clk *pcf85063_clkout_register_clk(struct pcf85063 *pcf85063)
> > >  	/* optional override of the clockname */
> > >  	of_property_read_string(node, "clock-output-names", &init.name);
> > >  
> > > +	/* power-on default is the 32768 Hz output on; gate it until claimed */
> > > +	ret = regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
> > > +				 PCF85063_REG_CLKO_F_MASK, PCF85063_REG_CLKO_F_OFF);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	/* register the clock */
> > >  	clk = devm_clk_register(&pcf85063->rtc->dev, &pcf85063->clkout_hw);
> > >  
> > > -- 
> > > 2.55.0
> > > 
> 
> -- 
> Alexander Sverdlin
> Siemens AG
> www.siemens.com

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--B1kxVD8HOxRY8rij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-clk-disable-unused-clocks-registered-after-boot.patch

From 68b91c1d8b64b0b9fc88b9036f9a4340e7a0a98f Mon Sep 17 00:00:00 2001
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 25 Aug 2026 22:54:06 +0200
Subject: [PATCH] clk: disable unused clocks registered after boot

clk_disable_unused() only runs once as a late_initcall, so clocks
registered afterwards by loading a module are never checked and may be left
running needlessly.

So record when clk_disable_unused has run and afterwards, schedule a
delayed work to run the scan when new clocks are registered.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/clk.c | 50 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 048adfa86a5d..817f916192ac 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -24,6 +24,7 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/stringhash.h>
+#include <linux/workqueue.h>
 
 #include "clk.h"
 
@@ -47,6 +48,10 @@ static LIST_HEAD(clk_notifier_list);
 static HLIST_HEAD(clk_rpm_list);
 static DEFINE_MUTEX(clk_rpm_list_lock);
 
+static bool clk_disable_unused_done;
+
+#define CLK_DISABLE_UNUSED_DELAY	(HZ / 2)
+
 static const struct hlist_head *all_lists[] = {
 	&clk_root_list,
 	&clk_orphan_list,
@@ -1442,7 +1447,7 @@ static void clk_core_disable_unprepare(struct clk_core *core)
 	clk_core_unprepare_lock(core);
 }
 
-static void __init clk_unprepare_unused_subtree(struct clk_core *core)
+static void clk_unprepare_unused_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
 
@@ -1467,7 +1472,7 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
 	}
 }
 
-static void __init clk_disable_unused_subtree(struct clk_core *core)
+static void clk_disable_unused_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
 	unsigned long flags;
@@ -1516,21 +1521,14 @@ static int __init clk_ignore_unused_setup(char *__unused)
 }
 __setup("clk_ignore_unused", clk_ignore_unused_setup);
 
-static int __init clk_disable_unused(void)
+static void clk_disable_unused(void)
 {
 	struct clk_core *core;
 	int ret;
 
-	if (clk_ignore_unused) {
-		pr_warn("clk: Not disabling unused clocks\n");
-		return 0;
-	}
-
-	pr_info("clk: Disabling unused clocks\n");
-
 	ret = clk_pm_runtime_get_all();
 	if (ret)
-		return ret;
+		return;
 	/*
 	 * Grab the prepare lock to keep the clk topology stable while iterating
 	 * over clks.
@@ -1552,10 +1550,31 @@ static int __init clk_disable_unused(void)
 	clk_prepare_unlock();
 
 	clk_pm_runtime_put_all();
+}
+
+static void clk_disable_unused_workfn(struct work_struct *work)
+{
+	clk_disable_unused();
+}
+
+static DECLARE_DELAYED_WORK(clk_disable_unused_work, clk_disable_unused_workfn);
+
+static int __init clk_disable_unused_init(void)
+{
+	if (clk_ignore_unused) {
+		pr_warn("clk: Not disabling unused clocks\n");
+		return 0;
+	}
+
+	pr_info("clk: Disabling unused clocks\n");
+
+	clk_disable_unused();
+
+	WRITE_ONCE(clk_disable_unused_done, true);
 
 	return 0;
 }
-late_initcall_sync(clk_disable_unused);
+late_initcall_sync(clk_disable_unused_init);
 
 static int clk_core_determine_round_nolock(struct clk_core *core,
 					   struct clk_rate_request *req)
@@ -4366,8 +4385,13 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 	clk_core_link_consumer(core, hw->clk);
 
 	ret = __clk_core_init(core);
-	if (!ret)
+	if (!ret) {
+		if (READ_ONCE(clk_disable_unused_done))
+			mod_delayed_work(system_power_efficient_wq,
+					 &clk_disable_unused_work,
+					 CLK_DISABLE_UNUSED_DELAY);
 		return hw->clk;
+	}
 
 	clk_prepare_lock();
 	clk_core_unlink_consumer(hw->clk);
-- 
2.55.0


--B1kxVD8HOxRY8rij--
