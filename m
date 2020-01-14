Return-Path: <SRS0=Th8G=3D=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01887C33CA9
	for <linux-rtc@archiver.kernel.org>; Tue, 14 Jan 2020 00:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD24B2080D
	for <linux-rtc@archiver.kernel.org>; Tue, 14 Jan 2020 00:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578961506;
	bh=AfbOkoOfBZ0Lq93SqNGArLGHFuoVeCsjXzMdoV78J8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QPAelORgJNXnGyuQjJpeMi7uBjLA9nD3QCWZ9fcZAQxyBHg81AlWjPJXupWVoBcLH
	 S1x//g/r095Hcz0JuE6DDr3N5Ttey5mnJTHNz7Mf820DmQ1aiK/TVocWHAl99zFH//
	 oG+6wCsCa6B4R32MQaihUMMzNj4tM7mtHBvm+f+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgANAZF (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:25:05 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45864 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgANAZF (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 13 Jan 2020 19:25:05 -0500
Received: by mail-oi1-f194.google.com with SMTP id n16so10143788oie.12
        for <linux-rtc@vger.kernel.org>; Mon, 13 Jan 2020 16:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UiO2+Fp93HhiZmZTyPCKddyYzvj9rECWLiqMRlRa5BM=;
        b=hUZSMy+mSf8LIUubO0l6QvGftfvxsxZPVxdgSY4b03p0+y8yLrgpv6BQ5sHJELtJfB
         MPrgPKRiIVTF1HD9ZkwTD4eGVJxuMOT3qtKrZ1TwiNJjmfU8eqb3Cs+jfnwduXQladju
         17cO7OGs1kTn80cmVzRGB8LBqOVPzXKJbe5JOTZMB9XL0dYMht3bJx5JnxRD+6ynwfBS
         /iwzYXtQHaLjWj/3QLn8nwja/QhUWteQnlr7W7kS/c4QkVopDw4a7jJCxUPJzNgEmgm2
         HfEVATU1xWGKsYRn39YHzXoUHYt5+Q9+NiTlG4RwUTfF4RmtMJzNQLUTq0r8cjhcULhK
         PZZg==
X-Gm-Message-State: APjAAAV7Tu6aw/EJUUjN5glHV+p0TtOh9cGQ2tnTPxJzpx/O8l2ISMxY
        jMMJrAXEBoZSeNjPaXeJbtI8w6eKJA==
X-Google-Smtp-Source: APXvYqx1ZfdhQAe3Ds6BYEsgvE6WOldGGZsv+uSlBGx5jucrX9/ymvddA9q2O8qU0JWdUL9jsevkHw==
X-Received: by 2002:aca:4587:: with SMTP id s129mr14232516oia.124.1578961504348;
        Mon, 13 Jan 2020 16:25:04 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l13sm4743904otq.78.2020.01.13.16.25.02
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:25:03 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220b00
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:18:03 -0600
Date:   Mon, 13 Jan 2020 18:18:03 -0600
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
Subject: Re: [PATCH v2 10/17] dt-bindings: atmel-smc: add
 microchip,sam9x60-smc
Message-ID: <20200114001803.GA13249@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-11-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-11-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Fri, 10 Jan 2020 18:18:02 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-smc to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-smc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
