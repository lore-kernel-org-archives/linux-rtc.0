Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C273148CF;
	Wed, 22 Apr 2026 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871685; cv=none; b=goq1aBfTH/RX62ABveS8ly/84AZIafgHo0p2tHKUI+IEBtIo+zPKEfS2/nMSHnvCak4CobBfcwEOqlsIX9NHLz7l6GiYVcF9Tu43Aj4y7cW4v0bxKbc83ZvWYvN8BeE2FEzuyFcQFn5J0YJfYVNim97i+9TGc2OXwuJAbwn9JRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871685; c=relaxed/simple;
	bh=j5mjbuZHUs3T+VE1ywP1N0KVLJLB/Ivpt2PboPyDndM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVjshrCS/eZvLfiRFf+gnFMxbGQ4qBfclhxbKcSANOVG7Bij/kaVa7byUSNEKaOOpQ5U+lGmUUaXWUD34uTjjg+c7Cu+/FY879MBs9aCKyy1UdiYJ94+IGN7IDbcAB4rM0aL5W3xDgkD5XSGztrwS0zvFRYpNCYHW5rJYkCoOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJLGbKx4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJLGbKx4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935C5C19425;
	Wed, 22 Apr 2026 15:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776871684;
	bh=j5mjbuZHUs3T+VE1ywP1N0KVLJLB/Ivpt2PboPyDndM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJLGbKx4Jc+VLWQ6Pu7MePSSCeZXqF/ELF0qsweJm4MjNqYe9ZtizITlvXKoQAvX9
	 azgHgBAQ/v5GqAeyA9sJhMVXwWtfgxurCB9SOpPi/7MQtKi7G7O5PyA6qkMZrcAFKP
	 UltWtsQEZQDrtoEPPJH5oszyACitKU4rsqNTOfdF6bSy85SrduMAP8KxmlQZYGDs5T
	 2yVKCTKMkznOI+xc1KcLue5L7bfXVaAKG8aICwusFC+9wRHlVIBpvFyqlZd57iWAz8
	 xHI7qaheLwZh2sAv7u9EriqVDLqkgjC0aeSA+J2sclNXRuaEVj9u0nHf3RMmNtNQnu
	 VTIe4qD+nwBMg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v1 1/4] ACPI: TAD: Use __ATTRIBUTE_GROUPS() macro
Date: Wed, 22 Apr 2026 17:24:08 +0200
Message-ID: <1961102.tdWV9SEqCh@rafael.j.wysocki>
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

Recent commit 93afe8ba9b01 ("ACPI: TAD: Use dev_groups in struct
device_driver") switched over the ACPI TAD driver to using device
attruibute groups instead of creating and removing the device sysfs
attributes directly, but it might go one step farther and use the
__ATTRIBUTE_GROUPS() macro which would reduce the code size slightly.

Do it now.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -605,15 +605,12 @@ static umode_t acpi_tad_attr_is_visible(
 	return 0;
 }
 
-static const struct attribute_group acpi_tad_attr_group = {
+static const struct attribute_group acpi_tad_group = {
 	.attrs	= acpi_tad_attrs,
 	.is_visible = acpi_tad_attr_is_visible,
 };
 
-static const struct attribute_group *acpi_tad_attr_groups[] = {
-	&acpi_tad_attr_group,
-	NULL,
-};
+__ATTRIBUTE_GROUPS(acpi_tad);
 
 #ifdef CONFIG_RTC_CLASS
 /* RTC class device interface */
@@ -885,7 +882,7 @@ static struct platform_driver acpi_tad_d
 	.driver = {
 		.name = "acpi-tad",
 		.acpi_match_table = acpi_tad_ids,
-		.dev_groups = acpi_tad_attr_groups,
+		.dev_groups = acpi_tad_groups,
 	},
 	.probe = acpi_tad_probe,
 	.remove = acpi_tad_remove,



