Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E23C433F5
	for <linux-rtc@archiver.kernel.org>; Wed, 18 May 2022 15:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbiERPJ2 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 18 May 2022 11:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239087AbiERPJ0 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 May 2022 11:09:26 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAC2195EAD;
        Wed, 18 May 2022 08:09:24 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 373EDC0003;
        Wed, 18 May 2022 15:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652886563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FLdoGJYGG/Ago8Jd5bcv62TJ96wqqFhxKMXBejyBWDI=;
        b=UW4pbngg4rU1zBTrYkx+RdpTzLmADSmoeA/zt9lRkipX7zw/Thx8eeWh/CzZtqdoB9H7mh
        M5gOyUbguyPaKEUrvhjjA0CiqUAsQ1NdOsrRjBxSshNGRbrchPbBATK9f7GNE12cd4FM44
        Yyh9rK8Auz9S7tyHL6J4aVHW/RnW1egC7BgqLkRUM1OTLegHRjAigWbyBKNdupjGDFC271
        ZMeg0C/xaaYLc8rt471NfYIocCdb6fSOgH+kjAIzbt+A9qXvpGNCM889n4k4zQlajENa24
        4FBSM3Ffu0B+oQSA3sT9V42eUBZmAU9zDc0di6/NEQLAXgboFalmkR/r5ZYjsw==
Date:   Wed, 18 May 2022 17:09:20 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tom Rix <trix@redhat.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] rtc: rzn1: initialize val in rzn1_rtc_set_offset
Message-ID: <20220518170920.4db16990@xps-13>
In-Reply-To: <20220518134747.3215597-1-trix@redhat.com>
References: <20220518134747.3215597-1-trix@redhat.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

trix@redhat.com wrote on Wed, 18 May 2022 09:47:47 -0400:

> The clang build fails with
> rtc-rzn1.c:291:3: error: variable 'val' is uninitialized when used here [=
-Werror,-Wuninitialized]
>   val |=3D RZN1_RTC_SUBU_DEV;
>   ^~~
>=20
> The val variable in rzn1_rtc_set_offset() is never initialized so
> the series of |=3D operations in the function will start with a
> garbage value.  So initialize val to 0.
>=20
> Fixes: be4a11cf98af ("rtc: rzn1: Add oscillator offset support")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/rtc/rtc-rzn1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index 980ade8c9601..0b4bf6e43464 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -272,7 +272,7 @@ static int rzn1_rtc_set_offset(struct device *dev, lo=
ng offset)
>  	struct rzn1_rtc *rtc =3D dev_get_drvdata(dev);
>  	unsigned int steps;
>  	int stepsh, stepsl;
> -	u32 val;
> +	u32 val =3D 0;

Actually reviewing this makes me realize I mixed two variables
together:
- val here and below should be renamed to something like "subu" or
  and indeed initialized to 0 here.
- a "ctl2" u32 should be introduced and be used instead of "val" in the
  readl_poll_timeout() call.

Thanks,
Miqu=C3=A8l
