Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275C368961;
	Tue,  3 Mar 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772542301; cv=none; b=mIPGb9tcr8XiP5a++1/1tqUsQgTKhtbVL/yDv0dcgRI7LlCXlr8J8wAxLSKgmKZBLx+EtihqsZZ1/EkwDVyRzM0yGjvD7Whzvd7vM1uyG53l92mhZaBiogVB1x05OcPRupHZDlRzMD6O28imJUzEnhkNOHXYfcRsT0YvM7YsVqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772542301; c=relaxed/simple;
	bh=MoOnUyWSlutDJoJAHKXLrk4GYbCLROToD5pESK10+hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVj0oAluWmC/MxzySUMBsx1l9pUIxr33ycvIz2fS7iSsSkUmS2e2PlfLzNbjgjATdZxW68kdVRIz1tDRPCH4mJM41N3CW9nuOWm8A0Eg3y861/tNyA4xsM57LBQvRTHBEek8XwbOW9QhQU+HP+ONJd9C41mK9mnwmdiko7W1dBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxyHMvsF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxyHMvsF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F577C116C6;
	Tue,  3 Mar 2026 12:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772542301;
	bh=MoOnUyWSlutDJoJAHKXLrk4GYbCLROToD5pESK10+hY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxyHMvsFUC4sG6QnWULK5gsI8kgnrtCdzrbDkRmbUXvFMJeW9OOSWuTPLBsbD5tq9
	 xTMyQ0hEuaTkp7CNCGtLE6+aJMa3CGjitqXv2wl7sC5Q4akha2brzJ3oo1ktIi4C7c
	 y/tfK3LPGJPUQQk7B2VPYwqvYeshGO7tE5oFeYg9WDWGwypxHTDD/2c3TzPBcFeW7F
	 qx4Qd+qhrlnAPBthR+aN8nIfsyliI8tAnymPBjK4qCdRGHX5ehrTcFvZnT/liuMQYh
	 TWr9qYSn6ewgFXz8uklgNouUdzsaMR2fMCqdT92wZ7K0CNno0MxUdutJoF9jb77cyB
	 O+KaEqZ4RQuUA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 linux-rtc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject:
 Re: [PATCH v1 4/8] ACPI: x86/rtc-cmos: Use platform device for driver binding
Date: Tue, 03 Mar 2026 13:51:37 +0100
Message-ID: <5087839.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <20260303060752.GA2749263@ax162>
References:
 <5983325.DvuYhMxLoT@rafael.j.wysocki> <13969123.uLZWGnKmhe@rafael.j.wysocki>
 <20260303060752.GA2749263@ax162>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Tuesday, March 3, 2026 7:07:52 AM CET Nathan Chancellor wrote:
> Hi Rafael,
> 
> On Mon, Feb 23, 2026 at 04:30:21PM +0100, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > 
> > Modify the rtc-cmos driver to bind to a platform device on systems with
> > ACPI via acpi_match_table and advertise the CMOST RTC ACPI device IDs
> > for driver auto-loading.  Note that adding the requisite device IDs to
> > it and exposing them via MODULE_DEVICE_TABLE() is sufficient for this
> > purpose.
> > 
> > Since the ACPI device IDs in question are the same as for the CMOS RTC
> > ACPI scan handler, put them into a common header file and use the
> > definition from there in both places.
> > 
> > Additionally, to prevent a PNP device from being created for the CMOS
> > RTC if a platform one is present already, make is_cmos_rtc_device()
> > check cmos_rtc_platform_device_present introduced previously.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After this change in -next as commit 2a78e4210444 ("ACPI: x86/rtc-cmos:
> Use platform device for driver binding"), I am seeing
> 
>   rtc_cmos PNP0B00:00: error -ENXIO: IRQ index 0 not found
> 
> on a few of my test machines. Is this expected?

Not really, thanks for reporting!

Please send me a dmesg boot log from one of the affected systems.

The patch below should make the message go away.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] rtc: cmos: Use platform_get_irq_optional() in cmos_platform_probe()

The rtc-cmos driver can live without an IRQ and returning an error
code from platform_get_irq() is not a problem for it in general, so
make it call platform_get_irq_optional() in cmos_platform_probe()
instead of platform_get_irq() to avoid a confusing error message
printed by the latter if an IRQ cannot be found for IRQ index 0,
which is possible on x86 platforms.

Additionally, on x86, if the IRQ is not defined and the system has
a legacy PIC, hardcode it to RTC_IRQ, which should be safe then.

Fixes: 2a78e4210444 ("ACPI: x86/rtc-cmos: Use platform device for driver binding")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/rtc/rtc-cmos.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -1423,9 +1423,18 @@ static int __init cmos_platform_probe(st
 		resource = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	else
 		resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0) {
 		irq = -1;
+#ifdef CONFIG_X86
+		/*
+		 * On some x86 systems, the IRQ is not defined, but it should
+		 * always be safe to hardcode it on systems with a legacy PIC.
+		 */
+		if (nr_legacy_irqs())
+			irq = RTC_IRQ;
+#endif
+	}
 
 	return cmos_do_probe(&pdev->dev, resource, irq);
 }



