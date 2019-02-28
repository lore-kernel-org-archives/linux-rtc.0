Return-Path: <SRS0=/zCe=RD=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731E3C43381
	for <linux-rtc@archiver.kernel.org>; Thu, 28 Feb 2019 08:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413F52171F
	for <linux-rtc@archiver.kernel.org>; Thu, 28 Feb 2019 08:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a4ePbeEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbfB1ILA (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:11:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33813 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfB1ILA (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 28 Feb 2019 03:11:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so20861085wrg.1
        for <linux-rtc@vger.kernel.org>; Thu, 28 Feb 2019 00:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Kb0zhL5b2fCTGF1is0yG3NN7eitIPcXhvstViLS2wwo=;
        b=a4ePbeEAxGf6AFCFOvncQrVGEKFoQFslS1UsxlDUuYoDouZ36g8AP/L9Cry4JW0Pi6
         It7L4Ws2XvZcWeHl7jq4rLhmq2lhHK0QMAC/T/K5JEHr69kB7d6OJgnmv4El4onkVYpT
         pOmsNnGO7Mo0qI+6tBD2cP212z6q2xcgBtcUE3+OVfGPYtuF/0lQ18uKnoqGBbV/xWzK
         0sicDVhErhCoOAqNjARlMljAWbA9IqItJWHWqJ1CqM5mKeR7O+X5LS8QqIZpP5rT9cqI
         aCuVIstVurqk8jQHSU6TXxprvbkPjCPKf4wGxchEdgoNsE/Avv2KjAYMcwO6hY+uH49L
         LxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Kb0zhL5b2fCTGF1is0yG3NN7eitIPcXhvstViLS2wwo=;
        b=MsdB9B0d6FRvH8dyUCMYx5DI+JAE2MfW41dQVKuGX+SyAv7plYBbDjNttVy7bdXUar
         EjDJUzkdS5MTAQBgj1WT/2VPa80QzwX7hDrCXg/Oer2JlJxkfSOuf0MyUbqk2hbpx+JP
         BB/4mBhckcykR55TDu5Ci5c+h6ZKTrhkNygU2Nu28VNK38Zg9PKB0QFifiHa8yboWUcX
         VT1SMG04gJZyLKFlZczx0FxlvQCMwH7V0vkmGlJXpbomv3uoMlQYAly91H9uu7ah9Y3m
         RQb8w15Ix2G9tPP62mWtLa2cUNBkFcGJ/aX7mpVIhYPrXmqWO2joXN2KWV48L8XroS33
         3fYA==
X-Gm-Message-State: APjAAAXd8KxkiKCKPNLNSpvbxS7yYWZ1X0X4ji0GTX61tdp+MreO3996
        bTiqnDUZKD3VFdOtqTH//ibDZQ==
X-Google-Smtp-Source: APXvYqyVnAgc4xwvVHcZQfrFGSLZ7I8vpIwrgLtASJ09e/9ABx1ylnNRtD/rMZvKS/mmyP2cqi9lyw==
X-Received: by 2002:a5d:54cc:: with SMTP id x12mr5137190wrv.323.1551341458219;
        Thu, 28 Feb 2019 00:10:58 -0800 (PST)
Received: from dell ([2.27.35.194])
        by smtp.gmail.com with ESMTPSA id p6sm54724093wre.63.2019.02.28.00.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 00:10:57 -0800 (PST)
Date:   Thu, 28 Feb 2019 08:10:55 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
Subject: Re: [PATCH v10 0/9] support ROHM BD70528 PMIC
Message-ID: <20190228081055.GL4118@dell>
References: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
 <20190228070450.GB3773@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190228070450.GB3773@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Thu, 28 Feb 2019, Matti Vaittinen wrote:

> Hello Lee and Mark,
> 
> On Thu, Feb 14, 2019 at 03:02:37PM +0200, Matti Vaittinen wrote:
> > Patch series introducing support for ROHM BD70528 PMIC
> > 
> > ROHM BD70528 is a programmable Power Management IC for battery
> > powered 'ultra low power' systems like the pre-announced NXP
> > i.MX7 ULP. This patch series introduces support for the PMIC. Please
> > note that this driver only supports HW setup where PMIC is connected
> > to I2C on A7 core. The other scenario is to use M4 as a power manager
> > and connect pmic to M4. On such setups the A7 can only access pmic
> > via M4 core using RPMSG virtio. Such setup depends on RPMSG
> > implementation on M4 core and is currently not supported by this
> > patch series.
> > 
> 
> I was wondering if there is anything that could be done to allow the MFD
> part of this series to end up in upstream without having to wait the
> regmap-irq changes
> (https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/commit/?h=topic/irq)
>  to be merged from Linus' tree to MFD tree? If I see it correctly, the
> regmap-irq (main-irq-reg support) changes are not targeted to linux 5.1.
> To me it looks like getting them to MFD via Linus' tree will take a while.
> 
> The MFD part depends on the regmap-irq changes and I think that most
> other subsystems want to have the MFD changes in before taking rest of
> the driver in their trees. So it will be a while untill all the changes
> are in. It would really be nice to have the drive in-tree sooner - hence
> I ask if theres a way. (I don't want to push, just ask if it is possible :])

It's possible, so long as there aren't any build-time dependencies
between the subsystems.  Immediate acceptance however isn't possible
due to the impending merge-window which opens in 3 days.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
