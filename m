Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794627203;
	b=UwqHoEt5OnKJMrFX60Fsjaxv7EtX3rP5zSv8cU3stElMxqOChyUocQkQXVgLqkxeIJum
	 GFdzR0e4agSRNjyYfuQIrcXpBykZngT13Ov6w8APegOIA/9N6ROxZnwX77Zxi+g7yKLRm
	 pFCKh6oI/8RsOs86kyiJbUkHcNY2QuXONfJ8WELH3SHh3y6WKYfGjINLj/+jS7hjnWPcK
	 mP/t7a1sXn68TN4y0QmUhOX0IoL6lfcDu1Zx9AIRVyCbURR6WPfF1iw21ye5tkuWfZ8p2
	 Lc+221N46+QXixsgOkKOXhndw0IKaTz4geVYMeKVADNuqRSlSbS/H96o0sAeDvQlVTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794627203;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=vPrQKAr5VJH4BBI1lFBcxcIpYXfnW30sT/Vt+7Z3g8s=;
	b=aDF6DiemNVSsobczS9PLR3t39u0j170o7p3qtdok07yfThBtYLpQ82RN2WLyBTkMC7LT
	 KxfMlf/dxOVytUqm5oDNLTHaH833Zc0caF6lIeD5TT7wlRImezlC3C2IjV491fPp4vNJx
	 xlSsdryxo1fLKCzV/k3P4F2dBRKRzgqiREKI7MM2p0JJGM46BdibSCHX5ifuYxbF33Egs
	 ueSnyWygsmfR/dopaXKTbwmVhGnzVhKye+DrqI9dp71yL9Xf3ahKe4Yc1dLx4cbaAOKjr
	 WsZLmzi1xhO+gzfkU3jJKkAhOCiTxTpLomi1WVSa6B6OM2rtetN3vUu8TUW3dT5x3LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=X+YBvNqC;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF7B606A885
	for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 03:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEF7B606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=X+YBvNqC
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cdd9d0c9bbdso1811376a12.1
        for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 19:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794627200; x=1795232000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vPrQKAr5VJH4BBI1lFBcxcIpYXfnW30sT/Vt+7Z3g8s=;
        b=T0h1I9PSBr7YQ07+BhwhtVymPoAGwsEQnySUGsI8EHHpdUMEOCSc1dLq7aJnUXMfgo
         NtShE3L7Ih/7AA+UFK8p3uthYTJK6fcoQyg4P0Ka+BfDR2upEbLaG0b6xM41t7ZPizFU
         1XFuZBnmsABlCFM7Ccw/wVrHpyrWNVXIhKkElPP8l+1D4K1IEW8ZAH7cCUSPVHJVg7Nw
         ylJ0YOcGinpjbQn6fm4r6oZQbGDl98wpPAgVAFr1UPhn0ZWpngZisMIIItJlXY9kFHPq
         WVDvbVPv93Vkee1S3HnF1ILpVlcRB8pKzKuUT3p0zvna0Gt5M4InHNcH0/jWmgsdIMgM
         1Ttg==
X-Forwarded-Encrypted: i=1; AL+hErGBEsT1sMnQgf1Ea70PPYoQlTvgvLx2Qze5a9Bgq8IAd8tMJdJ32jlb5DrgyWj4gmUQ3VIuI83DODQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LaP7CbAVutb895cvXDAORnc2XnNlqoxUiXsVF9QsybVNhvQFH
	CmnaAnx25KC9qVg0tkyW4KY6KRpOE/hoR1qj6xLois4+WXoblUrj7MgU/cFQXLv3JnkPd/FRuCO
	DQ9JHrZ1PjyyIPKpozpSS0SWV/awm+dFGme3scAXBBvEAFxpldGKxEvkN4+yv2zOIkpfV20KjY0
	CAmSIuCNBI6Jcy9Rd0FQkRO+32pL9FQwvGcPBoWljEOkUu99X2AvsJgJe3O0ZD3it4neS3oikMK
	scl08eGSYK/LGs3uSYj
X-Gm-Gg: AYBFou14sQi8JSfWa5gCTMoEfkv1HjVjmItC/U3Kxxlwm8iPNvJ9eRuQhfF0qJoIUx6
	cdiHWZQlPStuk/vMqJmGPlXwwu0E7KLRVxC0ktjAiAevUlknnNQrHN3tMCuPZjG1uI0HGspbc8W
	3eacmL5XaJodkZu6RMu1ZZ6W9nLhAuGgWMEVcOoH6o7AmVRH55MiOp15mWQkSM2BB9s8Wp8QwCP
	K0uQ48EFXmigy0leSRz+GwzWtfJMCj4OSvVEPwQVn/FHM4BdBqXKiJtwDd2wVRfebBq6fxoqRMc
	fsPsmhHveWqsQa0s6eXiil7zzOte1kWJnmsfq9GkPKSk0efft8ixcfMUUpuVSjdZ2KfGeFgzPZ/
	f4robhisjyPn3KOnnE1pd2T+c5jpgg8zIuyQSf8qSq4mRNbZYzcRiZX1Z3bVBVSzoJXWCe+Tmss
	dQ5gCQVSDOO/VgSrvSVozXyIZ1m49PDPkiJ8G1LQEl
X-Received: by 2002:a17:90b:3f46:b0:3b0:78c8:d56e with SMTP id 98e67ed59e1d1-3b1b0b8f0acmr4374044a91.27.1794627200077;
        Fri, 13 Nov 2026 19:33:20 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1ae999e55sm5684299a91.7.2026.11.13.19.33.18
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2026 19:33:20 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-370230d93efso7069893eec.1
        for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 19:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794627197; x=1795231997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vPrQKAr5VJH4BBI1lFBcxcIpYXfnW30sT/Vt+7Z3g8s=;
        b=X+YBvNqCsBPhobT8XfUh8BNwt/IakaOaOdCmLYQ/8e8ABs/d/vh8M35AtEDnlUOebM
         U2sB2Om1fZa3lERcQyEOgoWOsVPe7TBBXwX1eTfezZZyTqQ1GGZyhPb8ZM3MC9iSetq6
         n6PFay1Ls1TDX5ajdn7JVVNm6cIDO0heJrhMg=
X-Forwarded-Encrypted: i=1; AL+hErHXbsIwJ9xhk6oO6hbzwxKQjBd7B/Lrb6Zt71A+PIajdkpczIpA6n4rZcnerYIkJ7SPb503+qZvP5k=@vger.kernel.org
X-Received: by 2002:a05:7022:7e83:b0:1b3:bdd9:cc6d with SMTP id a92af1059eb24-1b503121791mr4956816c88.32.1794627197443;
        Fri, 13 Nov 2026 19:33:17 -0800 (PST)
X-Received: by 2002:a05:7022:7e83:b0:1b3:bdd9:cc6d with SMTP id a92af1059eb24-1b503121791mr4956781c88.32.1794627196818;
        Fri, 13 Nov 2026 19:33:16 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563df84fsm21906906eec.20.2026.11.13.19.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:33:16 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Peter Robinson <pbrobinson@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sander Speetjens <sander.speetjens@gmail.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] firmware: raspberrypi: Add bcm2712 revD compatible check
Date: Fri, 13 Nov 2026 19:33:15 -0800
Message-ID: <20261114033315.876198-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102170227.1719206-1-pbrobinson@gmail.com>
References: <20261102170227.1719206-1-pbrobinson@gmail.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Florian Fainelli <f.fainelli@gmail.com>

On Mon,  2 Nov 2026 17:02:24 +0000, Peter Robinson <pbrobinson@gmail.com> wrote:
> The bcm2712 revD doesn't contain the base SoC compatible of the revC
> because they're not fully compatible, we need to check both else we
> don't match for newer devices and the RTC doesn't get enumerated.
> 
> Fixes: dba67294e2151 ("rtc: Add Raspberry Pi 5 RTC driver")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
