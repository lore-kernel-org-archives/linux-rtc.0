Return-Path: <SRS0=5rMO=SE=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3AAC43381
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 06:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893D720857
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 06:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmNLl0vL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfDBGdQ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:33:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44130 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDBGdP (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 2 Apr 2019 02:33:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so5820537pfm.11
        for <linux-rtc@vger.kernel.org>; Mon, 01 Apr 2019 23:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dGqWB01UKA8c4kwxS0iCgHftp+tJ9Wcw6mLQjNF0TE0=;
        b=BmNLl0vLo9f8z5N62YMyIlgmX7fBkQDr7nr2CYp0uESZJM9Hdz0eYV3d9OcJrF4fYr
         OhZnQU4kVfUEdfYpKOiN9A/600UMQAxn7A5NoSqacsqWPzGldlxA5XjK+8v1BaYNY4Cw
         x8l+ukJ5vbZ07fljvRwC/RSlueen6LdkBDLfm6Rhs1ggbZkDQfZg5byiHXJ3+Mu7jDRz
         CRz6kzoFAvdSviIxdWE5uVT1F+2ECENn+/7unsuKXC2KKTgwHhqnVQ9ltsg4nQ/9dvrh
         76MZl2QsLfq4S7DTmmyFg0TRGtaENGEP2zOpMOFrFRlGxsocEq+pQaWQcRgQXKFqa2hz
         PeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dGqWB01UKA8c4kwxS0iCgHftp+tJ9Wcw6mLQjNF0TE0=;
        b=qNbj6tFucW43xxMrXDE7PjmK//rkfYoefN3LVkw5jbtMHiFgWBBsH6TJlzuBK5ptw5
         sLMeShy3bnBi1rSxPZnHltXW4kK96rn0DSWlbLrd/X9Z/GmxMEpkK274CffAzRBeG0Dj
         xUngEMjSCtUPAebuNf0rkgPxNJi0i4YUkBTmIjnJpbRvg/luQ9KwcwjphiwN9npWx0Ij
         +yNh3xercqr0KZrMJRCs2Nb9mHPF6gXZtTvCUzqM4zSVilqUpMjey7oxS3fHbuDQAWkt
         hEpMu0BPE2h6njal5RoVbAzQKqscLveWM7wOb4uqlQQSstxz2XFTylmgYVpkvEQIA26l
         7Ubg==
X-Gm-Message-State: APjAAAVv9W14hXD1gI8GEQH9ZiF07X/xngkCLCAvqbwLtuXGwgKXqiuJ
        xZw9p2lBh3TR/uy3inlIVu88jg==
X-Google-Smtp-Source: APXvYqwrtQN2dyO1OKOZVCSwrKbosY/KUjSi8Vc3JafExGnzdr5/VsmW08UtbDMM8j7IlKs3IfngHA==
X-Received: by 2002:a65:5c49:: with SMTP id v9mr65666434pgr.150.1554186795145;
        Mon, 01 Apr 2019 23:33:15 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id l5sm23982922pfi.97.2019.04.01.23.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 23:33:14 -0700 (PDT)
Date:   Tue, 2 Apr 2019 07:33:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     heiko@sntech.de, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v7 2/6] mfd: rk808: Add RK817 and RK809 support
Message-ID: <20190402063305.GZ4187@dell>
References: <20190102102002.29245-1-tony.xie@rock-chips.com>
 <20190102102002.29245-3-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190102102002.29245-3-tony.xie@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, 02 Jan 2019, Tony Xie wrote:

> The RK809 and RK817 are a Power Management IC (PMIC) for multimedia
> and handheld devices. They contains the following components:
>   - Regulators
>   - RTC
>   - Clocking
> 
> Both RK809 and RK817 chips are using a similar register map,
> so we can reuse the RTC and Clocking functionality.
> Most of regulators have a some implementation also.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/mfd/Kconfig       |   6 +-
>  drivers/mfd/rk808.c       | 192 +++++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/rk808.h | 172 ++++++++++++++++++++++++++++++++++
>  3 files changed, 364 insertions(+), 6 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
