Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1749E2C3749
	for <linux-rtc@vger.kernel.org>; Fri, 23 Jan 2026 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769129409; cv=none; b=OjU/HGBW5owkdKBCB92uam255NoAELL9U1pLKKejJC1wrjh53THSsxtQBDw8dpq2h8eODhzoyX7otSEGbtmfsH7SpjRcYeLtOjCPRKds3g1iyxOjtNHr/JEEBHIsz3K86mDLJ4LOpAIVeHXSmnC4pTc4t6g1FD1L1b0FoCZgXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769129409; c=relaxed/simple;
	bh=61fxTBvmM+nEDTnrxV8wyBLBgYPiDsz7hg08HBbLwi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goR4LFbT+XXwwpMV2azJylirLO4/oWfoJaBhkCrkd7+r/l8tjoW7UvARnKPy6om0nGOfWS6TYIGd/Yi7DgAJnlWOOYJUUz7s3t9zQHzOSNnS4hPIO6Mj0w9Yv2WwYlsk4WB9yiP7vDcIsht0YaQ5/yt55xP6uauD5/lD15UeUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UEWrLgmH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=szdmPHyL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEWrLgmH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="szdmPHyL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769129397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GoBRPgL92gOt6XV5p8QK+5WmhSABAsu+khI/gr5kMBo=;
	b=UEWrLgmHHcRpi51aAWBwZQW32Ki5r9cXzrC6+n0xO92Vbca3hnrziZEUOwgdpnPUbntI/a
	roend+QGV0UZ5yzWIILvUwrXRVetYIYEACXpKkVGk401RZKHs9zz24nPVOJiOkqXm8YZOU
	b4ZSr3l2spEdOvw5xz2sWukDUfz2vcI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-cBFE7TUUNrqyKlsFiLuAKA-1; Thu, 22 Jan 2026 19:49:55 -0500
X-MC-Unique: cBFE7TUUNrqyKlsFiLuAKA-1
X-Mimecast-MFC-AGG-ID: cBFE7TUUNrqyKlsFiLuAKA_1769129395
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6deddd7f7so235643085a.3
        for <linux-rtc@vger.kernel.org>; Thu, 22 Jan 2026 16:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769129395; x=1769734195; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoBRPgL92gOt6XV5p8QK+5WmhSABAsu+khI/gr5kMBo=;
        b=szdmPHyLXUq0kYRZ3/oR6NhVM7v/p/1dn3wFOAKID2ISmeBlGwJ+Q5GO8Snz39Suwz
         rrPDOGaFywpXkwpA95R96xF4i5A5TS35qFkbD6bpMMTLP3sq7dJlpt+hb1+vRramO4CD
         RQyyqJHpEN+7DgoVdI2xhetCQIThHaufiRwzE1YUZiZMewpjYwygi3Rsqn783T84VPt7
         RSdg1EynPNX2FZNI7ok5MUkCx0RRBn6mP1+k90f6GyYUEFw3NsUIorxHpTx+J0ec+1R7
         4NnvTTxjtfgGuYrXZWspOVkaJQxK3OjabSMv4tC6QFBSJB6UyVXR/aYb1jNGc40ro9xj
         JkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769129395; x=1769734195;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GoBRPgL92gOt6XV5p8QK+5WmhSABAsu+khI/gr5kMBo=;
        b=lakbYRGeemTetYHt/jLGJ/7dzqlLUdyMjhH80hy0tj89DFHF6461tr/xfzaVnDqqd8
         olmPB1yVDlaQIVkUXvDpEY6KlmzqBb8DR0Pzkba2o/7bj0BWDL7IXAmNmh9bW1hJGon9
         WmQeDSo5I9iO5wyQo5/Gu8Wj9y+nTVsFGkq+MWT4HIdEggy/TU/KLGn85Pc81zVAjZKV
         WuqNulMjIEJyVuX5kJIkGyI2D14HmTAEgmo1Z5E4OhINAkE9OpQ+vZnNMcvj2ycWTmI/
         We3SgjT/A7nK4PhJwPaaZO7FA6mfv8SY4YKu/RIZD1jNsgXVTX1bDRf5Yqn4isXN1YE8
         QokA==
X-Forwarded-Encrypted: i=1; AJvYcCX98QYYh/8Fqc8ghLaV4v+Ss/dJ2HE0wpZIeN8/IsOs5i7OSdCWJg7hdZv1tmYWH/6zfUbDfJNKU+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpQWcVrhLtnClvq3AwvR5GrTIxzig+l8Ew1I7yLQNgXPGLhsH1
	83aqGTLE2juiQ+YG2wfRkJNmY/sr7kbamwYL6JedCswvzNmd1V2/wGRtzGRQXGEwD9hwDUgRdiL
	kgb5vWcE3njBOys8tl7J8P1Tei5HKLGOEZh/zOw3qDUH4ORdSnT8TA/UYzR8qHQ==
X-Gm-Gg: AZuq6aJZeF4+q402kQ23SmwJO7RF/PKp4YF4tSZuBCTzanGnrYDjtGyPC+7xdP92aOI
	I07GdCX/YZdep4lFnINll0av6/qc5VC1lkxG1ziz3xGSa+z7ysFcoCf1RSjnc/21RPkGztiJ3Fr
	vh4gc9iGowijoGRfl52uPNF7g/3rFNoU33bIploogytVlpoRzqqDdxrCx3ziVIops1VKOq8mkir
	Yxd4zKBG1Zp5mM9Mlfa+ZaRByXGNAXOFKt1bLlMfj7L617bUw3U4XVwZWC1O9MWF5X4D7O28PqQ
	JmJJ9j9DDcgGk3y1KUqL4oxOdn0YqrEdoRrMSeaJhU14/R4Oj03TDxF2sy4nYAyojoUcgNoZ7f9
	k5zlubvzzpF3PySS7gh50eu+ljOQjQ6lGH6N+iTMpxrRA
X-Received: by 2002:a05:620a:298e:b0:8c5:2bcc:fbc2 with SMTP id af79cd13be357-8c6e2e4bf45mr189823285a.81.1769129395202;
        Thu, 22 Jan 2026 16:49:55 -0800 (PST)
X-Received: by 2002:a05:620a:298e:b0:8c5:2bcc:fbc2 with SMTP id af79cd13be357-8c6e2e4bf45mr189821085a.81.1769129394805;
        Thu, 22 Jan 2026 16:49:54 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e383c2bfsm54737785a.29.2026.01.22.16.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 16:49:54 -0800 (PST)
Date: Thu, 22 Jan 2026 19:49:52 -0500
From: Brian Masney <bmasney@redhat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 00/16] MIPS: move pic32.h header file from asm to
 platform_data
Message-ID: <aXLFsA_bEkXLr33P@redhat.com>
References: <20260112-mips-pic32-header-move-v2-0-927d516b1ff9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-mips-pic32-header-move-v2-0-927d516b1ff9@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Thomas,

On Mon, Jan 12, 2026 at 05:47:54PM -0500, Brian Masney wrote:
> There are currently some pic32 MIPS drivers that are in tree, and are
> only configured to be compiled on the MIPS pic32 platform. There's a
> risk of breaking some of these drivers when migrating drivers away from
> legacy APIs. It happened to me with a pic32 clk driver.
> 
> Let's go ahead and move the pic32.h from the asm to the platform_data
> include directory in the tree. This will make it easier, and cleaner to
> enable COMPILE_TEST for some of these pic32 drivers. To do this requires
> updating some includes, which I do at the beginning of this series.
> 
> This series was compile tested on a centos-stream-10 arm64 host in two
> different configurations:
> 
> - native arm64 build with COMPILE_TEST (via make allmodconfig)
> - MIPS cross compile on arm64 with:
>       ARCH=mips CROSS_COMPILE=mips64-linux-gnu- make pic32mzda_defconfig
> 
> Note that there is a separate MIPS compile error in linux-next, and I
> reported it at https://lore.kernel.org/all/aWVs2gVB418WiMVa@redhat.com/
> 
> I included a patch at the end that shows enabling COMPILE_TEST for a
> pic32 clk driver.
> 
> Merge Strategy
> ==============
> - Patches 1-15 can go through the MIPS tree.

I'm just checking if you'll be able to take patches 1-15 this
development cycle before the merge window opens?

If this series goes to Linus during this upcoming merge window, then
I have 17 patches ready to post in a month for the next development
cycle that can go to various individual subsystems that allows all
of these pic32 MIPS drivers to be compiled on all architectures. The
patches also fix some issues in those drivers that were found by
kernel CI.

This merge strategy makes it so that we won't have to deal with any
cross tree merge issues, or immutable branches.

Thanks,

Brian

