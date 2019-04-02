Return-Path: <SRS0=5rMO=SE=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37A0C43381
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 06:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF72220833
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 06:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3Mju4yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDBGsw (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:48:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46531 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfDBGsw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 2 Apr 2019 02:48:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so5837129pfj.13
        for <linux-rtc@vger.kernel.org>; Mon, 01 Apr 2019 23:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wqqhpOshfOodSZDcIGAPglJ+O3e5ZBYgiqEoT7BdCo4=;
        b=C3Mju4yyYYV/s231iRmErUBgy7w3R+44E6tTiFacEPZFTA9EupNspRRfnWXsgiReT0
         K+yhbRT7HaNHI0vrekyPCIqX9oqZENJfFAt1XIVbEouuEb3tF1rTrlSgBkwdk82lhZdM
         p6GBtGGm62JqMvZvlh/NkADOtm68YVR3S9uBGPIO/z0DxlWP9UeOls6POaR69eCoO3up
         6WdtnuOnfyjQmil2SYqh6RWUKjfgraB2iySzU13QNR/5OVdttmg4A2t34/L7OXadyDi2
         KiNoLQQ4vgvmrhgXpaLzodOPF1vdcW8CqPaMu0z5i9Mu4mYKGJd73NWnm2Xblpwy9eRc
         hCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wqqhpOshfOodSZDcIGAPglJ+O3e5ZBYgiqEoT7BdCo4=;
        b=NRCtN2dbXHY9oNyvse9lJRcShSP+37vuJbqDRIjzHMCT6njDx7fRf/m1FHioWJnhuT
         wpclJ/hKWIXad/7yrwY9bpAx13GWXf7wN166sNvay8EJ+bRJ3dKqi31HBBOCgLMqKTV0
         YU6bgq5WjZAMW+hluVG9py48revEpVW0HfVVeabfMlvOSlA493V3uGdc1rn0GPgx4hd2
         /aXOHdcjJ1TaWIxCg9YIJw7mkhCU506DX7J1l2Yd62vdF+5mi7I+AJhrJ8tqnmik7LiD
         aWVQNjfe18PWR0DiJPkG3zoqsHLDGU6M5Gli2cSz+IzZjJdyjlzDV8Nd5jVkoI2TWoCx
         uKrg==
X-Gm-Message-State: APjAAAWZEz+irGi9REsGq7exUrGzbMG5GumWClg7RBdnA/95ht2hegIM
        7h2GeiGJgnCcTkFBphXdQG7xEw==
X-Google-Smtp-Source: APXvYqyddrSgIMwsV1J9ZanAa0NUJW1WXXZ+A651l1mQbU1UKhz2tfmN0n0yyJh/hu/tHG4Qv7GqFA==
X-Received: by 2002:a63:711d:: with SMTP id m29mr19511042pgc.109.1554187731349;
        Mon, 01 Apr 2019 23:48:51 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u4sm38874820pgn.12.2019.04.01.23.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 23:48:49 -0700 (PDT)
Date:   Tue, 2 Apr 2019 07:48:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 1/9] mfd: mt6397: clean up code
Message-ID: <20190402064842.GB4187@dell>
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1552275991-34648-2-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552275991-34648-2-git-send-email-hsin-hsiung.wang@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 11 Mar 2019, Hsin-Hsiung Wang wrote:

> clean up code

Please explain what it is that you're cleaning up.

> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

The patch is fine though.  When you resubmit, please add my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
