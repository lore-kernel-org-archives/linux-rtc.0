Return-Path: <SRS0=3b/R=P3=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CEAC61CE4
	for <linux-rtc@archiver.kernel.org>; Sat, 19 Jan 2019 19:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8582084C
	for <linux-rtc@archiver.kernel.org>; Sat, 19 Jan 2019 19:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547926863;
	bh=APEWp+IHO/cZlXFGFEDw/fbVJWTY9xY1ECdhtx9bR4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NAUwvGMFpAiU8aEVhKcQl2VQ6E9xXl5+wz5BTmnrnoZFBezxQu6DvEnTf2ivDUZn4
	 QL1eUty4HApr74PIkVuuxjvqipSGuA7nmrSmZuGbGZXH/CsdZxtwQ9IDUFPS4K997Z
	 mHFLlCbwJ1pvBeHuGQrccF+hJSrUcLCw8PV2W7lU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfASTlD (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 19 Jan 2019 14:41:03 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39006 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbfASTlC (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 19 Jan 2019 14:41:02 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so13699564edt.6;
        Sat, 19 Jan 2019 11:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tzwuCg2bkY81FAz0Ea5/4w2i5JmA0qusmNkIRsvknXE=;
        b=p5cICdZTcYFdxQ2pAcVVu7c/FytR/zfRKGiOHEwMSTkVqF67tvDgxD/hVAkWMzjp67
         iyH7hAWU9qtS/C3xlvpCnK+XRHs00ZHlHLuwPXYwzuL7i19xzFKbpUpT/9H+s9M/upJa
         u3b06JXgSxIoIRPqINDtd8S+OvtcXF1Whs5eT7OpHQE60FxKdkFC9KqPwVCfKLc65w/L
         m41GM1X6aE9KCNAIcR/E5c8nIkRYnRt2PRm/xFD8M6oLC7xDSC6X7LnUoRnZtWzs1nWr
         oOT7i0x9Kol/ePRNyIg+GVG0h1BO14yWEIcjPH6tBYCzTPq1CWl9+EYz8u0OJWxitT5m
         tuEw==
X-Gm-Message-State: AJcUukffL8nCHNFS9VIMMQj5PrmxPgqFrkiQIKteCOKrjUUIv9sgy2J7
        jnFBab54kjTtNhd889ctTB5VzgIw7+c=
X-Google-Smtp-Source: ALg8bN5Vis19l0prU9joeV0OaXdwFWZjt93B9IiNchxGyoyAzleFLkAc33Z9EucjPjBvCreaacSHpQ==
X-Received: by 2002:a17:906:5c45:: with SMTP id c5-v6mr18745919ejr.83.1547926860713;
        Sat, 19 Jan 2019 11:41:00 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
        by smtp.googlemail.com with ESMTPSA id 49sm8104270edz.59.2019.01.19.11.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Jan 2019 11:40:59 -0800 (PST)
Date:   Sat, 19 Jan 2019 20:40:57 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] rtc: s3c: Use generic helper to get driver data
Message-ID: <20190119194057.GA3465@kozik-lap>
References: <CGME20190118132845eucas1p2c3e5f6dadb6af90a3701fca03599e094@eucas1p2.samsung.com>
 <20190118132837.15713-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118132837.15713-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Fri, Jan 18, 2019 at 02:28:37PM +0100, Marek Szyprowski wrote:
> Replace of_match_node() with of_device_get_match_data(), which removes a
> few lines of code from the driver.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/rtc/rtc-s3c.c | 13 ++-----------

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

