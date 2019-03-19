Return-Path: <SRS0=7wLf=RW=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8AFC43381
	for <linux-rtc@archiver.kernel.org>; Tue, 19 Mar 2019 14:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBF12083D
	for <linux-rtc@archiver.kernel.org>; Tue, 19 Mar 2019 14:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="puQOKMZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfCSOrX (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:47:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38712 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfCSOrV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 19 Mar 2019 10:47:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id a188so16734679wmf.3
        for <linux-rtc@vger.kernel.org>; Tue, 19 Mar 2019 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YzjCpRmDA9wR1xnyZxcnZ23puQ+O+dahoaacjFD0+qo=;
        b=puQOKMZ0IH4UlmFsa1rH5QgDMBI84tDQy/feHxhesTqYUVtnxCXbbiBawDzEGXCtWH
         meiT7fs8tFknGtl65jxRSiYPvmdhOmdyMipizwMkoblW6v6JbE6vimFXsxyeroRQX8ri
         M576S2t1Nv1o/3OoAYiNtvSaCyoplpoo4X+HM3NrZy0x0IFzxBcMNbKZ4MlIvjx5iz2n
         KAZVE9zaOR3SvA+HbZRvOc64v2vwKadrIYVZno+azCjRYlSLgkq9nk/9DUKs4sQW8rhR
         NywGtkS7kvLiCpVJd836howA4pbwXeNZiHokrMVxgjs0rLekFBuISHbmy/VheBAGLJ8E
         Tp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YzjCpRmDA9wR1xnyZxcnZ23puQ+O+dahoaacjFD0+qo=;
        b=DdU7GkHH5X4fmCatmgTC/kt3eOrGdMjtsseUiQYRj6xQZC9xynCJbyF8040SrtUbNg
         7jctSiX6jsGBrDAwPfEBe1SpSBTO3s8R9U5Jfxdsry1HCvIpX75YvuQtv9zPZUg0zFcf
         VL/Tiy9WPhFbW3FnCf9Wx8rrVn2/AjzeCrsGk/jZDfKGlioner9C2zr2ooLAHUKZl/Wr
         ja63MRUB+P8h0JfFkraXOVk/8GBmVDyvofquAZO0ufkezzj25FHiZjiY0bTeHJIEQFed
         w4OZZUSfC5i6BYR6+qQKhfyNW6L5RItDlLtzfZHmx8HquHH9iWcF7lyhnOv89UK5MiZF
         I2lg==
X-Gm-Message-State: APjAAAX8HFTv6+WYYgOiV4g2URC6Qr8olXVoS7oCK2cgfvSMTgWmUbnD
        9SRVgVbfiaurv7/4OOvCHlyCEA==
X-Google-Smtp-Source: APXvYqxcNtjhQ0z3cetH6v1VZ6VuFLNCn9gYpf9j1i7ObgC46aGf6b75xKQFHEKb3Sy18IszK26IzA==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr3895176wmj.108.1553006839764;
        Tue, 19 Mar 2019 07:47:19 -0700 (PDT)
Received: from dell ([2.31.167.140])
        by smtp.gmail.com with ESMTPSA id z20sm2812630wma.48.2019.03.19.07.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 07:47:18 -0700 (PDT)
Date:   Tue, 19 Mar 2019 14:47:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Tony Xie <tony.xie@rock-chips.com>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v7 0/6] support a new type of PMIC,including two
 chips(rk817 and rk809)
Message-ID: <20190319144717.GG4731@dell>
References: <20190102102002.29245-1-tony.xie@rock-chips.com>
 <36121846.smLYK4jT4q@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36121846.smLYK4jT4q@diego>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, 19 Mar 2019, Heiko Stübner wrote:
> Am Mittwoch, 2. Januar 2019, 11:19:56 CET schrieb Tony Xie:
> > Most of functions and registers of the rk817 and rk808 are the same,
> > so they can share allmost all codes.
> 
> do you have this series on your radar somewhere or should Tony
> resend the series? As it looks like it fell through the cracks somehow.

It wasn't, but it is now, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
