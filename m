Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D8B47043A
	for <linux-rtc@vger.kernel.org>; Thu, 15 Oct 2026 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792101253; cv=none; b=QWn+FBhgIIuABcLgBuLZ6TxV5Rjd9+oxhj1RvASXLM7FZSxlxl7sKvRE1aHvfIAHvtOjvde8cjJ1Kptwh7Tw6Y76OM9ptXIxWxa4ldP44Ejp7XMsx5IviwUU/vea8ejm9XzgQOV5iRBGQ2FipI8680nPA/24PRBJ39zn8Wko2Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792101253; c=relaxed/simple;
	bh=mTWjh1JQrwNxj7ZlXA3XUGEhDVTf88r+HHtbsFOvNXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQrbx9iwnoodHu768fRWZ/33S+wpzxDSMa6e3C2c/jfrAnzvvP50w4/MW4fH62cUAuWRgeDwYJ+k5Is+XGhf4X4AbQqO1vjPiW4EnaRtGUnC+dCV8T4XPGpIxeAKbeszXwsBWKgmeCywFs1oBxzuQ7aSjFZNFEeHl09rbS3FyWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TMfzgqvi; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TMfzgqvi"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93c5b7f5bfaso47627785a.1
        for <linux-rtc@vger.kernel.org>; Thu, 15 Oct 2026 14:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792101251; x=1792706051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9diFlksQ+a3TSPkkbPJqrE0Tb5epfFzmuOiQPjkFUKk=;
        b=TMfzgqvikSyW26Ic4LvVDgbPDkAAt3MlUnJCDmasOeJYROsQtTnj5I1hBnRPulrLLQ
         A8UVHn53AJAZfcR5+gO0rEf/KtHekgSMuRHE8g4gHhMZiF2r3rGoQphrKHVACy9lODIj
         zNLrGUTTyx/zR9ARXdhpxiVKvdbi86dlAXCw41Nw81Cs69VjjfawGBVUHVeFhMJw05di
         PbIcK79waR5XZedC9In/UNArIzcUoYYLdSgFXX+Z2xz2HOJmp1QKsNIVrN/jpn0MgvRP
         skdIgKoGrP2z1XMdw7r8P0yF+lNZ0yzXNzcyHOBB+QV6Dx6B/1A+/1LFGvRXmTdUTVQb
         3MVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792101251; x=1792706051;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9diFlksQ+a3TSPkkbPJqrE0Tb5epfFzmuOiQPjkFUKk=;
        b=oHeiXkJrql/iran65/5TF/pcziRTnCX+87nyHRSkMDLZwPxSuizu7FAnDmyLvL+CrM
         B7VZWeV5dZuIDA5xsrukI/GtHx/GwslVdm0xwJmab7Q/cuGeBouGSX4lcc5Fi+Y2NODi
         DDWdW3i4enJB/uvNO8Qrb1GbKRCMSQ36sBDS/KJgwTivvKsPRQ0XHHEE788wpOhoVsx9
         ZrK8+J1xUzSH2qCDr1PzMokt6rtHJ7nWz9x9lGAwMOrDYcFDq2B1bInzpy8uxob8q1ba
         re9MybIOHzB2AGMvGC4n9dQN55gICra6uFEVV/KO5HrGatbCxPv0OgTH9SBJRJKt47Xl
         xZ2w==
X-Gm-Message-State: AFq9FYKkwFQxO4PwQ+oGMzAlmN8+jmg5CaIaQRbG0nR+/gBFvXnf6DEX
	VDJNZdWyqWljgDQgvQNFbeFs87afDb4ZV1Q/Vm18DW1OiOOVQzEujmdp5irN1Vnz95NXYSMAf0e
	BlsS0TwM=
X-Gm-Gg: AYBFou05vLrDaD3E5agyRpyfk/JKYrT2NFghgKFXhTPRWzAtTeL7cW95uLMX74YblqU
	l8/s+Lk5ODeKCxJXwJXMS59g5s/kHeIQeYasHGZogESQrkCHRjIs+vM5x2518TpgmMUkjo4i9FN
	+FE+6jun6NMINmKKjhcJ2RU8ZJvEHd8zk3gXopNFUyNHrDN+FjEvY5NEPbG8Wz5mY1lUp7De9RY
	oJ6Th0IKJen5Ly0FgkqflvtjefeQsHSrL95G/4n7TAzs3GQ0VZF4gyTGUY/RcBZ/Oogaj+8nngH
	foBEpaIb2un8sXlx4pAnJjQ+Iavnlu1jKDgdFLwekanCdlOf36dYkjjKJY2VL2C+Vk1wuQkWaCH
	t0L6iKRZygCzZAQLzKFfptXM/H18bXJIM61zkWwVaiDBpVBLNgcNaxKYSZm142+Pa9//iOnyTU6
	h8w/7NwCHr5H6NMMt/3VaPn1g+zZ7HUZ0CgQguRFFtAmZoDP/JfOgBiZ1bxHiLd54G/HbSqY+2Q
	1Ih+/7vczF+YmkA4SR2vVNvkb+r35P0C/1E/zD6vqxq5Lg20gGGDSZW7fet2L+99A==
X-Received: by 2002:a05:620a:4801:b0:93e:5677:317b with SMTP id af79cd13be357-93f17f4a93bmr261885485a.25.1792101251234;
        Thu, 15 Oct 2026 14:54:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbb1af26sm6141716d6.33.2026.10.15.14.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 14:54:10 -0700 (PDT)
Date: Thu, 15 Oct 2026 17:54:09 -0400
From: Gregory Price <gourry@gourry.net>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rtc@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [RESEND PATCH 2/2] rtc: cmos: Honor explicit use_acpi_alarm
 parameter value
Message-ID: <atFLRRT_RN7etz3I@gourry-fedora-PF4VCD3F>
References: <20261015173029.3091872-1-gourry@gourry.net>
 <20261015173029.3091872-3-gourry@gourry.net>
 <sashiko-outbox-173258@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-173258@kernel.org>

On Thu, Oct 15, 2026 at 05:36:16PM +0000, sashiko-bot@kernel.org wrote:
> > +static bool use_acpi_alarm_explicit;
> > +
> > +static int set_use_acpi_alarm(const char *val, const struct kernel_param *kp)
> > +{
> > +	int ret;
> > +
> > +	ret = param_set_bool(val, kp);
> > +	if (!ret)
> > +		use_acpi_alarm_explicit = true;
> 
> [Severity: Low]
> Will this trigger a -Wunused-but-set-variable compiler warning on non-x86
> architectures?
> 
> The file-scoped variable use_acpi_alarm_explicit is declared and unconditionally
> assigned here, but it appears to only be read inside use_acpi_alarm_quirks(),
> which is wrapped in an #ifdef CONFIG_X86 block.
> 
> On architectures like ARM64 or PowerPC, the variable is written to but never
> read.
> 

I could not get this to trigger. Neither gcc nor clang would fire this
warning for a file-scoped static.

~Gregory
