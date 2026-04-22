Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46CE319871;
	Wed, 22 Apr 2026 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871681; cv=none; b=OWFzxvjR7FmS+20iAfOk6ZtvRVa0Q5XhQRaPQRrvKlKblZUYG/JTfw+zCJjGtWLWxkgzUsEAo2O1h1jKonAghL+Sg707HDlLeDj1nvULYJatjNfUjvkCoJ16Lzv6OGKYqQXbGBI2mV2IyXRn2YEkiT/FolBSqpJWY9VDi6wMkMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871681; c=relaxed/simple;
	bh=oSafszJYxFNWSN+LvfPCQEZQcYEaKbGWLlT5qonPtcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWEJM/HYXKaVMunQCotuQHu+zqKNLZP9C0nPwg61p+GkOcZ7a2RnUayQllYG2fuoiBcQV/YNZeXM6R89fstyv/L7q6o15pIQSRRmrLVxuc2VoWvnMNJGjWHy34giiNTg5/icrajyCMpbptu9DytRSIxR3DPkw1jlfzt97WNy3NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABr2JXpD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABr2JXpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DF4C19425;
	Wed, 22 Apr 2026 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776871681;
	bh=oSafszJYxFNWSN+LvfPCQEZQcYEaKbGWLlT5qonPtcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ABr2JXpDqDMTGG3sbhbsy1ZpovCb9jceJVpA2jTtivG+mInRtgwamAOMQAFNtrtgs
	 RbBf8sGcv/DTAT2YO1Na/p9eDrLqXuc43LSuq0IvbjHB+GeRaTTKH27896Z1GjX6eO
	 EmIue775Ln0s9eJQKVogO1RNEgGty10UvFq3loNM50iIjHR9dYTbjL5tC7f2eMx6+Q
	 6ZQyJzZKGqX0p1syRO+CbiVd8VBYx0uACh9aT0pD2KNBOHpAhpi4jD8EggNC9z9VaJ
	 LzOzSPYRlc9iatG5z3eUiqpXXYlsp0QKJNSx4B4aOfBZPAXQa0mbi9MZfQjM0z0MRZ
	 bdGAWJx1OERbA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v1 2/4] ACPI: TAD: Use devres for all driver cleanup
Date: Wed, 22 Apr 2026 17:25:46 +0200
Message-ID: <14001754.uLZWGnKmhe@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2415066.ElGaqSPkdT@rafael.j.wysocki>
References: <2415066.ElGaqSPkdT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The code in acpi_tad_remove() needs to run after the unregistration of
the devres-managed RTC class device so that it doesn't race with the
class callbacks of the latter.

To make that happen, pass it to devm_add_action_or_reset() before
registering the RTC class device.

Fixes: 7572dcabe38d ("ACPI: TAD: Add alarm support to the RTC class device interface")
Fixes: 8a1e7f4b1764 ("ACPI: TAD: Add RTC class device interface")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -792,9 +792,9 @@ static int acpi_tad_disable_timer(struct
 	return acpi_tad_wake_set(dev, "_STV", timer_id, ACPI_TAD_WAKE_DISABLED);
 }
 
-static void acpi_tad_remove(struct platform_device *pdev)
+static void acpi_tad_remove(void *data)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = data;
 	struct acpi_tad_driver_data *dd = dev_get_drvdata(dev);
 
 	device_init_wakeup(dev, false);
@@ -821,6 +821,7 @@ static int acpi_tad_probe(struct platfor
 	struct acpi_tad_driver_data *dd;
 	acpi_status status;
 	unsigned long long caps;
+	int ret;
 
 	/*
 	 * Initialization failure messages are mostly about firmware issues, so
@@ -867,6 +868,14 @@ static int acpi_tad_probe(struct platfor
 	pm_runtime_enable(dev);
 	pm_runtime_suspend(dev);
 
+	/*
+	 * acpi_tad_remove() needs to run after unregistering the RTC class
+	 * device to avoid racing with the latter's callbacks.
+	 */
+	ret = devm_add_action_or_reset(&pdev->dev, acpi_tad_remove, &pdev->dev);
+	if (ret)
+		return ret;
+
 	if (caps & ACPI_TAD_RT)
 		acpi_tad_register_rtc(dev, caps);
 
@@ -885,7 +894,6 @@ static struct platform_driver acpi_tad_d
 		.dev_groups = acpi_tad_groups,
 	},
 	.probe = acpi_tad_probe,
-	.remove = acpi_tad_remove,
 };
 MODULE_DEVICE_TABLE(acpi, acpi_tad_ids);
 



