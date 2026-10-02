Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A695748035A
	for <linux-rtc@vger.kernel.org>; Fri,  2 Oct 2026 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936122; cv=none; b=LN7MhGBOWJlyWSri6fwIViBIEkS+6Way85M9li56xzdkAThOK9Vf035DFeBwiUfoRasAmTxxu7gz9hBjpCaflgcpVxX7o05mx6bzvKppMhNTAq9rHD8dY7xi0jzoDIUJPSpuGIogodBK7OPgRMROvMYZBRFkhUh3K2Ww56vIDT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936122; c=relaxed/simple;
	bh=yAVhP8PsllXd5JMSaAqxyn6fr2wqCIosgODOdfksmGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k97o1BUIj489xaFyJA1rmIDbpU7FXXGAGwnxbZsIZ1nEVpr3+kd0UMMNo5KHOlfMhZKLLUgpgEbU311oGJw/+saycUjYg2qFrwrB+/tnEgn/xo92iESUceGsa1j4+Wmo7Fa/ivW+856eN++2VYgqhp1mtFQfdke2TKojE8M9kzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hmQ2PF3X; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hmQ2PF3X"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so59604735e9.0
        for <linux-rtc@vger.kernel.org>; Fri, 02 Oct 2026 03:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790936119; x=1791540919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JhQwbNzw9q/i+NrTWwZM6JBPmiP7W8ERT5MTaCz339E=;
        b=hmQ2PF3XCIBFdeBQgJX8bRbz0CIvk94btAJ/lW7B0P/h/w2p4J9y1aEjX9dI50mKwA
         tsVz12m94Aetv92L35cFD7xcWqakXhuygDokkL2TKyguGQgjvkRC4SnOGEahwfIzLXP1
         Fqsqw3YBKArkFnCssRQj6srkUZRWgLY7Hz0xFz5pcoc9QxuQqH4hpMTMNYyVIQthO6PQ
         3xKh0SxOVU8/vRvSSaJeJVebWfBfX9QwvRsETXN5Amd0CGEiWlssu9ik9dw1yJ079Y/E
         qwUM24tjDMD8Q2ZBXniooTz5rh2obU09siswH2m3yp3ZYaEBUIESaS89M2Ykzf/7zfr2
         9I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790936119; x=1791540919;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JhQwbNzw9q/i+NrTWwZM6JBPmiP7W8ERT5MTaCz339E=;
        b=kEuwwAuak+0h/BIb92umCeUZhReE84ghbYHxMAcBSU4tRjyGgcsUOpNAsetN0jmHEh
         PMSuJXcFybyLDuoxwEG9767TmDybPIUEtkk3A7eE0tXUgkWygNM1atJRAxfgmdAr5j5X
         XSYJaJNJNYd08VpGkffYFwzZYqlLnU17SDXFaZmQ9VdsYZypAlR/wRSYZd2B+NEsxgfp
         Mt6BZvnuy0LcmIiHqlLaU7UhA40N4I1aN7wSLwl6n05x0S+KsR4FUb/oV2HmgnVCq1c4
         dC9eObUzC2i81rHOdqRtXdCvNxLuGkkSPuourf3aq2h4jWDmNQehPAsZrBpqF3kneI3M
         go6w==
X-Gm-Message-State: AFuF++lcv5IYT7F503GGEd+tzCqow8+/2qx7JP/EU+x3xjJtwFNtmLnA
	J96xYsT0q2kKEKK1PFrIh1w24mzHXUoWDsz8nEGBML0MIlyjhslDmXTwUPiFDps2DpsJBoniDFC
	FyeNx
X-Gm-Gg: AYBFou0tLyU7zjJrI9AGcel6SVt0zApufOx2z8DvY4hni62SeTqvFaYryn4YZCBZUCi
	ZWIh5F2ETUxNgNvTbhcB3+GWSvf7R8ji/JtBtDtghDTbqGRJUYsd+ihxil6NV1Oc+svYXO2O6m8
	5ISol35m1jFBq8mqudRF9SpiijcdDhJbO2Fx9cJZABjaGWXQZjmLb2uDLW/1UUUL193kex3oVKq
	zu96DxD/xoGcOnE/S7MyFyFIMRMVqBX8cIeA1HlKa/A4wpk8tJjtxZfIjoO0lZlG+Z6YfMlXAUw
	e4AKQu9cyP6M/PIHL7+64r9oXQLM5Oh7meLhRj2vZoN+PPHleep1ejGkcVIsri6/kQn4CmNxGTg
	BtLRuotDpjB/NkgBW6f9U0dXAiW8m618PJHYjoy83Aa9e5asMs6dOwsbvhPKCUAqBQEby182ivl
	zHYffkC4EjjGHPr10G+lGruXTs3lHBRxpSMmVAu7XuH2G6To3hMbDPeoW5xaXDhkapX13W2ToRC
	LALnQ==
X-Received: by 2002:a05:600c:8b2f:b0:4a0:f0a:976a with SMTP id 5b1f17b1804b1-4a027579f41mr39944895e9.13.1790936118308;
        Fri, 02 Oct 2026 03:15:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::6:adcb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104602sm4990029f8f.26.2026.10.02.03.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:15:17 -0700 (PDT)
Date: Fri, 2 Oct 2026 06:15:16 -0400
From: Gregory Price <gourry@gourry.net>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	alexandre.belloni@bootlin.com, rui.zhang@intel.com
Subject: Re: [PATCH 0/2] rtc: cmos: Fix ACPI RTC alarm handling
Message-ID: <ar-DmqHQNJ90HZ55@gourry-fedora-PF4VCD3F>
References: <20260909225132.1392883-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909225132.1392883-1-gourry@gourry.net>

On Wed, Sep 09, 2026 at 06:51:30PM -0400, Gregory Price wrote:
> RTC update interrupt emulation can stop delivering events when rtc-cmos
> uses the ACPI RTC fixed event. On an affected system, a test that waits
> for five one-second update events completed only 40 of 50 runs. The ACPI
> ff_rt_clk counter stopped at 218, exactly matching the number of events
> delivered to userspace, with the event status set but delivery disabled.

Gentle ping on this.  tl;dr: in-tree rtctest is broken on some hardware
and there's an obviously boot param fialure.

~Gregory
