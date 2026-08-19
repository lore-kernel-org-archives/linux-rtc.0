Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6BC48A2DF
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157048; cv=none; b=sSA0rUEicieCuLnbAR8ogLTULI1jQrh1teQeYXsx7U1pRyh6sT/bd/66QKDvJdiR0ljqioEfp7OsaBbT8t4cH4KvPoPWM4SCoAPKDnXkJqncpHdj7bSD3+oeY93GYquRsIXKNXV+zSeglnXRX2Hr/kUHzmiWoFDw6hj3GwgiSds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157048; c=relaxed/simple;
	bh=+RbH6+ZvTZHAgigFfyaeWloQNdXTgu2iBfAYtwN2uPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDH8ESQqxCFEzBR8stHQqIcuLIQxUSuc/Va643eDVgfAJAwrbptYEG00iZHEc95DkmYzT4OXWe9Uvy+K7R117C8Vq3+ZAAhUGovQU1SPNVGytVGjQyrnPNB9rpaxUUBHolZ1iuqUr3tf8IHT3KKIn/7AXjti4cmuFzgwiifjtfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LtQJ2AEr; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LtQJ2AEr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 114C31A173C
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 16:30:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D27645FF42;
	Wed, 19 Aug 2026 16:30:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D7D411C7590C;
	Wed, 19 Aug 2026 18:30:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787157039; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=NsT5dUpowUwfV48p84bBBJHpjn5rT5djw6bOT8FiOVM=;
	b=LtQJ2AErDxv6YW+cmN+5RpZByvWZ9kFwRtyTHB2M8Zvfax0TxQOVEuFXkAqIpNIG2veB6T
	kE2MvT6ythFZax7MstE0Or81jG6leDKwK6exmUQViTK+Kqm8v5auuZU6f31t7Z6j9rVsLq
	/Ni9xDcv4z/B+uZnCDTUW2KDgC2N4LPDeaVW1TWWxKIaZ022NhR5UjTXorQgM3ZWV6reSX
	QvOYsH9JBkLAnCFnrd3aQDhECeGQaQx803P6O1I4NjCACjZXCMNiJJmXp7fHcwzhMWiUH8
	6AD7pWQvTSsUw6tMUIxeLgp6Co5WQOjY6kt8vljdpD1HGcet3zvJ52Gvn8nW1Q==
Date: Wed, 19 Aug 2026 18:30:38 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: brcmstb-waketimer: add missing MODULE_DEVICE_TABLE()
Message-ID: <178715693841.130787.17987818567876748858.b4-ty@b4>
References: <20260704121734.54941-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704121734.54941-1-pengpeng@iscas.ac.cn>
X-Last-TLS-Session-Version: TLSv1.3

On Sat, 04 Jul 2026 20:17:34 +0800, Pengpeng Hou wrote:
> The driver has an OF match table wired to .of_match_table, but does
> not export the table with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
> information is generated for OF based module autoloading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the platform driver, and the missing module alias publication.
> 
> [...]

Applied, thanks!

[1/1] rtc: brcmstb-waketimer: add missing MODULE_DEVICE_TABLE()
      https://git.kernel.org/abelloni/c/402c89d28fec

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
