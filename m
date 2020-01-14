Return-Path: <SRS0=Th8G=3D=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A93C33CA9
	for <linux-rtc@archiver.kernel.org>; Tue, 14 Jan 2020 00:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A91621569
	for <linux-rtc@archiver.kernel.org>; Tue, 14 Jan 2020 00:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578960991;
	bh=8eR2k4N3/QElfnpXUzRtCjcysj33XTmq362d49xB6mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D9qJRTish2AgY12jddtqrTdaBeMt/zPRBNaMVT+Vl3zOCz3rlWiWl3Jo07+zRGu9k
	 ZTQYv6+btbcpoI4ORZdxuSW3PM4MnnmqkbpHP71AS+I9hO7xEpkhSecm+/pg88em5N
	 zQgG5DWxGDAGiGQ3EeeYB7m6QIbi9bBoD9h83WgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgANAQb (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:16:31 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45291 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgANAQa (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 13 Jan 2020 19:16:30 -0500
Received: by mail-oi1-f194.google.com with SMTP id n16so10127346oie.12
        for <linux-rtc@vger.kernel.org>; Mon, 13 Jan 2020 16:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E6IJAm/G2BZsEtWssBpYlld99L9pgrhy2OUvTYO1Gu4=;
        b=COk9mEJOnVuUeRG8t5pj1Ox3A+PgLPX52QDsFdnWqE9Xj9FoVz71dTsHCpxXBH2vUG
         3jTAhk+LQ4vlfzF2dIYuxWEoPJulTe8M8xt5kQEaIdUsCyQg45ghKYwa0pCLAPCYrOsQ
         bIZZw9ufR66BHr5msqBZEn/OFIdHuLjD+JsFxR8dem1NQ/pdS/J3ua2y1IoFJix/qGma
         2xJkXq53yToBgO+4egdQMx9fFAnQEXKSg7OF2CSG2nSIdOswHuIHFH6+yAyy1I6Xx543
         sckoHmB9e3gBHRRgcNroJVLZ1TMu+G4V9mnQwR0ikQxHrMm9/Yk1tAfyuolWN0DSgiAY
         Sypg==
X-Gm-Message-State: APjAAAVIpzvYqQ57zEBkjFI7Cgv2rSz2c5cpDV+gjgAuYwBeI7xMHM6w
        jhW3Log/p4Gw3SoCPZuX68Daq+3S3Q==
X-Google-Smtp-Source: APXvYqzTA1cDJzrlpSkiufTvGCc351lKfLHSYbhcw+E2RU+NrQtN+CpgkA325/ZUWSzwjGwpWTNS6A==
X-Received: by 2002:aca:5658:: with SMTP id k85mr13921285oib.153.1578960989856;
        Mon, 13 Jan 2020 16:16:29 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p21sm4789908otc.21.2020.01.13.16.16.28
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:16:29 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22198d
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:16:27 -0600
Date:   Mon, 13 Jan 2020 18:16:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        lee.jones@linaro.org, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 06/17] dt-bindings: at91-sama5d2_adc: add
 microchip,sam9x60-adc
Message-ID: <20200114001627.GA10411@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-7-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-7-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Fri, 10 Jan 2020 18:17:58 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-adc to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
