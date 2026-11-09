Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794239104;
	b=BteHwiipju9LCuMOrDRSXzD2KFR1Xed/RuBXSk4V7ehAJYoZyI/bhuLSgGx+pIa42Tn+
	 14UZq8f/yAUp6XFLcXg2MzbV0jQ1xJjmKCf5X+oiyLeQGk9w7feEqHZfleLvYmoBUXQaz
	 xD05Vo4PM/jB0D+cHnfyXM2f8dIipfTnJzZNghpGzc33eLus++RBC2slmG2OIzxdP3Nyg
	 JlATriFPQ1OVqqOGN63Huthhwh+W7FAwl0AFBflDNWpAQ6aPpQEy/XEDRWuGZFq7eAu9Y
	 QOtaG5BNbhiqAIy3/1KUKlhNmykPgVYH0j3q6stzRlac1uvoL2CxvliuKwWksEgQvkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ctMZmsxVPHwk1efT7mcbMQI5sey2JS1SJlSmKpoSEmA=;
	b=i1nnQ0cFmQMzUsqqTOdhivNELH1d3ugiGzosCiM1YtlY8/fU2QekFiGaccy/zc8VaXKb
	 0vlM/oJQnZabIUDV14IU3vEtp2UvFoisCUBo2mXYQBlYqcoY+JLtHiG/oyCac88xYMxSn
	 W+T2vBvZlImpaf3dBorAZXOH6SC47JwkM3UWG0K22febQsRjdxt3nsyg5A20adFzUPwMN
	 rcnv+jwSZk77O/T0z0GHdPufwO1SRsBbYkqMiIehb+AcnTu4C+gqD6R7VvfOw/GJ6hJ8p
	 YxYGlg6ID2Al1oAjDr4weACOJmoyDTSWPN4te0bF3SvNvVhN/CgV5q9woFeHBKO12Lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aVg0Psww;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490B2606A330
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 15:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 490B2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aVg0Psww
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so1689785eec.0
        for <linux-rtc@vger.kernel.org>; Mon, 09 Nov 2026 07:45:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794239103; cv=none;
        d=google.com; s=arc-20260327;
        b=sxsIcWjeN30IYnLn/y1C0xzU0hk/hCF5u//3nMR8PKuHLpssYRN3YQkkEe5QzFkaqq
         y5WhO73R7Nz14x0lTpA76gOPnJHuhXCYepl8SNMtJ1gK1eGPzbhJOxTXz3UoA9MWmvpu
         SaCN9wtcppFgZ63BGkPI5NdYr314YG+ZqVY2k4ZKj17OiPfFnJ18TGpgCP3Jxzx2Ln6D
         iap4nHaslXhJXelRWsAhM2e9UGxD+QigMDrhiUB74SmH27q3iSBOZZ29CvdIsJa2t8Eh
         dPpKPN/xNUCPelr8l5IW5QN+1jPGcY+ta+DhQZKtw4V0a3frMKAooX/CVRnJx7XUqzcb
         jfNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ctMZmsxVPHwk1efT7mcbMQI5sey2JS1SJlSmKpoSEmA=;
        fh=XvNL9hQL32E5gGt0juJxYB0QUDI9Nr4q81zHiZcyDeA=;
        b=FxEh7F09brt/jkgldRh+R9jp1WcV2ADkis4FZLslrnHQm2nTTVNLTRtbyebIaMyieg
         JpGV5FmoLvmEvUmPZYPkqIJGnmQxiSUJRD2pJsQXHMXdE7midS8002VZRzKLBsTO7n55
         o2QBrJG60q1Ij0TZI1BtPEKv/TKPEzrgJ60W778fdILWOQ+f3UaMYDF7nCebXwFCxw3F
         7Ykaea9GRgsnWk7yJBsmNkUBkc0F3RQYPwWJ/NKP0VQmmt1C/dc8McIohy5HeXJ2DD9v
         9NkPmThb0Dc0q4MXEW8/hrQ0I+Vvj8oHnqoImYtrzx6qLAK4mPHWXMpMjLpeK64uDuHQ
         ndDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239103; x=1794843903; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ctMZmsxVPHwk1efT7mcbMQI5sey2JS1SJlSmKpoSEmA=;
        b=aVg0PswwY53Y1ZbhOKWKHq6I+XVXF2v0WHXI2GLYAInyhgZSnU8LjDtFdZ0fwFLG2O
         BbTWxNf9swnT9aecxdK4u+PqIeiGLDSG9E0ZsabQa6sVoxE/Yq1Wk8+VQHrZjpWX5yRD
         kDTz47x/FAWWGk0lAw1jS3oxEXLYN7G6kB6JBR9SLxByxp2HIbvjOnLzR9mGs8M45TIz
         qw5xrve968WQEkpFD8sR7lCRvqGmOy+7njy2OWI+YuM3P854nmGS3/GSrO0jglZMCQKq
         uyfN+ExQWiOS3NN0qPVvh2PcqOEIE6LVw3qm6wy5oHPpwNOhE5teY005tZFWTdeO+Wpz
         j4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239103; x=1794843903;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ctMZmsxVPHwk1efT7mcbMQI5sey2JS1SJlSmKpoSEmA=;
        b=EX+GkR8qngFs03LuWS16b22jMVYR7ZnWAkTT0Ow3YPPI9vz+bP7vPUl2ZYPTB2rplF
         LmmvDjRoZUhJGJmwui8ZRmeSvLUOv56ghv7gqx6YP/iBsbWemF8npwtk5oE1OkqL8/yl
         A8qyo9C67xV8HRccDIYR8yR46Lbn7BhsTSiYS4HQmKtesETfTNR60ugMfKhW94mqGCL1
         /XO1duVmlrel6SvGmDqbWAIMGIES798PjB980qwCXOy2gNb4IZef8lTeHWGQ0pAd0Tis
         IEtaNJCKJrjKtfip3PFqdQdGDBydJOsE+GB0lslzkuOG241i1wsvKspPjZRshVyvfQWK
         /Hig==
X-Forwarded-Encrypted: i=1; AL+hErFiyZJuoNR+4lR37FCZ/LtTqOwxjDFnT2U70UWjM7Cd2F2kU0UCDZ1eKqqmBcAKlUAZkoqFiicwolg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HNVG+zpVWfZOcSNtO9aocIkmugYazrRMiq+xVZy8UVD/SBdJe
	2b+rv8sG9ormQnVmK2fcXauWIF6GtVPefNl0XGtJ3JP+sVf1LCZV6oWOmoT2u3QpvqTiOQgvvOx
	RAyKsiGegr279kxc/rBme55dcF6ao3as=
X-Gm-Gg: AYBFou3wpynC5Za7dy1iZcU/NwiWNVvZjLJLoc6VA9clhm+9cBZtkraVngbOZpQo4q7
	nzEP8vxg8WPngSxvx7dA0wZjDdF/ZgngZOf/DDz5xZaSb6V3UH0I/nyhvY/IyBLYtc8QG4IYl7x
	4HniieSjIDZKT4VViwd+ScrSGdpFb/ieqJjaaJ7cjFpgcpSJJTlcoFfcHzk0jjRUOXx7pZYQXZR
	mhncupbZPMnl3khMa9CKYlD0UhIHsZWZAzpQfPHCk1bP02txxd7wXu4hiXzo+3cTkZKDbaSWps3
	Pn3OxFGUsN25oPtSoFmJmpUxjVTsUr7qfo0qdB6hSGiiZ18JBW5KzziSbF56o5OulStMOdnDRG3
	tsGcIlErr2856LzpufSxn4NkoIXUeH/VXAC7tQw==
X-Received: by 2002:a05:7301:7004:b0:36c:9b35:5d46 with SMTP id
 5a478bee46e88-372571d9ac9mr8099191eec.26.1794239102976; Mon, 09 Nov 2026
 07:45:02 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108212826.15890-1-oo.hehir@gmail.com> <20261108212826.15890-3-oo.hehir@gmail.com>
 <ff0906c3-478e-4ad6-ac30-1e0a7cc35a41@freeshell.de>
In-Reply-To: <ff0906c3-478e-4ad6-ac30-1e0a7cc35a41@freeshell.de>
From: "Owen O'Hehir" <oo.hehir@gmail.com>
Date: Mon, 9 Nov 2026 15:44:25 +0000
X-Gm-Features: AclHuK-AhO-ARD3koIln2PIQIf1KmWM7RSd3LNIFnaM6Tz5301_ColSop3oW-YQ
Message-ID: <CALp3LZ61ZYcWz8CPQZJbJSDfAt7cgyyqA_bp+Gwhyr2peBVwKA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] rtc: Add StarFive JH7110 RTC driver
To: E Shattow <e@freeshell.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Hal Feng <hal.feng@starfivetech.com>, "ziv.xu" <ziv.xu@starfivetech.com>, 
	Conor Dooley <conor@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"

Hi E,

Thanks for the review.

> Is this copyrighted work from previous year 2021 being imported without
> modification?
>
> If there is modification then I would assume it needs appended your
> authorship and the current year 2026.

It is modified, so v3 adds my copyright line below StarFive's.

> Align 8-char tab stops per Linux coding style, and then tidy up the
> extra junk clearspace on some of the defines

The values line up in the file; in the patch the leading '+' pushes a
few of them (TIME, DATE, CFG_HOUR_24H, SW_CAL_VALUE, EVENT_UPDATE) one
tab out. The extra space before some names marks them as bit fields of
the register above; as it reads as noise, v3 drops it.

> I note that JH7100 does not mention RTC in its datasheet. Does JH7110
> RTC have any commonality with JHB100 and if so then would rtc-starfive
> be a more suitable name for the code filename and module?

The JHB100 clock and reset bindings do name an RTC clock and reset,
under its Peripheral-2 clock and reset generator alongside CAN and
GMAC, whose inputs include no 32 kHz clock; the JH7110 RTC is in the
always-on domain. I searched for JHB100 documentation but found nothing
on its RTC beyond those names, so I cannot say whether the block is the
same. I would keep the jh7110 name, after the first SoC supported; if
the JHB100 turns out to use the same block, it can reuse the driver with
its own compatible. That is what the pending JHB100 TRNG series does
with jh7110-trng.c. I would appreciate advice from Hal or anyone who
knows whether the JHB100 RTC is the same IP.

> Review use of authorship macros as appropriate. This may be okay as-is.

The driver is derived from the StarFive one, so I kept its authors and
will leave these as they are.


Owen
