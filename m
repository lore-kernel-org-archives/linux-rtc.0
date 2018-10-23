Return-Path: <SRS0=vqqW=ND=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFFDC46475
	for <linux-rtc@archiver.kernel.org>; Tue, 23 Oct 2018 06:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A942064C
	for <linux-rtc@archiver.kernel.org>; Tue, 23 Oct 2018 06:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOAP+bRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A942064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJWOsF (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:48:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36155 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeJWOsF (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 23 Oct 2018 10:48:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so267360wrw.3
        for <linux-rtc@vger.kernel.org>; Mon, 22 Oct 2018 23:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kW5fR0njpXy7BRl0EhManAPDjgZpGoiV9D/hR3+QT+0=;
        b=eOAP+bRDeC5yL309FIJW9lL33r6OY0XdwFi/s7P1poSjx0nwUU8ozivCbmbOUUm7/8
         oAOr1zSgb1SWAo84eABFVKiX9k91tMCUa3AaSGFa24V5wQuPVMhX3A4xoxtwYEq908EB
         NudCUNHDPN4ZrhkcC5v2C1T7lM/d3jUsO6Nc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kW5fR0njpXy7BRl0EhManAPDjgZpGoiV9D/hR3+QT+0=;
        b=qaJwfCw+cmnCY8PkGrGMjTIKsjGik7adQwBcM2SyVyP+vAgWsSolhjp0Iyj8WVsbwn
         wRtCeqphv4dnq11UJRpXZzjHHk37APYJlRxC0OR0wQQ/RSmhxhNHFC8uRngedg4nl44e
         qrMVz3u89eMKHUrb7nyfVgGeSF1oJPyi0DsWkgUz9wdFBKTVsBectxIgcFNB1fkPh8OY
         fvEKn5pGQm3xRIl9mbPqc/e7/0CclbqS4crp3ys3kXliCyuMZiLrUVJT7MOmGXWl8N0c
         XpD7dUZWS8yh2IA4IYwka1WpPyX0UrSjfb967IeNaPFH2XvPRdLMsl6jJPvYZSav3w1I
         OsfA==
X-Gm-Message-State: ABuFfohwKIo0IDuHk7Ei1TQlzrf2OqeNuy57qJsONKw4JYaQdtkYicDh
        byw0zPJx/wCJZXURkuAsrLOrGg==
X-Google-Smtp-Source: ACcGV63H0fNsvoUiUkVxSPaYN0fmhsQoRliXE3EjYhi9HltDWaI9SqodQRMYBTZcYUbbAInhggJjyg==
X-Received: by 2002:adf:8bc5:: with SMTP id w5-v6mr51071700wra.110.1540275965113;
        Mon, 22 Oct 2018 23:26:05 -0700 (PDT)
Received: from dell ([2.27.167.33])
        by smtp.gmail.com with ESMTPSA id e133-v6sm442351wma.42.2018.10.22.23.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 23:26:04 -0700 (PDT)
Date:   Tue, 23 Oct 2018 07:26:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     tony <tony.xie@rock-chips.com>
Cc:     heiko@sntech.de, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v3 1/5] mfd: rk808: Add RK817 and RK809 support
Message-ID: <20181023062601.GS4939@dell>
References: <1535081441-20718-1-git-send-email-tony.xie@rock-chips.com>
 <1535081441-20718-2-git-send-email-tony.xie@rock-chips.com>
 <20180911114732.GL4185@dell>
 <b0f9fff3-3084-91b3-fa78-5163ebd43bbb@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0f9fff3-3084-91b3-fa78-5163ebd43bbb@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

> > >      The rk809 and rk817 are a Power Management IC (PMIC) for multimedia
> > >      and handheld devices. It contains the following components:
> > > 
> > >          - Regulators
> > >          - RTC
> > >          - Clocking
> > > 
> > >      Both RK809 and RK817 chips are using a similar register map,
> > >      so we can reuse the RTC and Clocking and regulators functionality.
> > > 
> > > Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> > > ---
> > >   drivers/mfd/Kconfig       |   6 +-
> > >   drivers/mfd/rk808.c       | 218 +++++++++++++++++++++++++++++++++++++++++++++-
> > >   include/linux/mfd/rk808.h | 172 ++++++++++++++++++++++++++++++++++++
> > >   kernel/reboot.c           |   1 +
> > >   4 files changed, 391 insertions(+), 6 deletions(-)

[...]

> > > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > > index e4ced88..83810d7 100644
> > > --- a/kernel/reboot.c
> > > +++ b/kernel/reboot.c
> > > @@ -49,6 +49,7 @@
> > >    */
> > >   void (*pm_power_off_prepare)(void);
> > > +EXPORT_SYMBOL_GPL(pm_power_off_prepare);
> > Why do you need this where no other driver in the kernel does?
>     There is a gpio_slp pin for RK809 and RK817，this pin has reset、power
> down and sleep functions，so
>     when system is going to power down, this pin is needed to switch to
> power down function，and then we just only control
>     this pin to high to power down the system in atf at last。

There are other PM call-backs that you can use for this.  There
shouldn't be any requirement to export and call functions at this
level directly.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
