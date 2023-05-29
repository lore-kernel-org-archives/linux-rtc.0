Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8946C77B7A
	for <linux-rtc@archiver.kernel.org>; Mon, 29 May 2023 23:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjE2XG1 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 29 May 2023 19:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2XG0 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 29 May 2023 19:06:26 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D96994
        for <linux-rtc@vger.kernel.org>; Mon, 29 May 2023 16:06:24 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-ba8374001abso5473646276.2
        for <linux-rtc@vger.kernel.org>; Mon, 29 May 2023 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1685401584; x=1687993584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Gwe8KUB75vJ8ATbX2tI7fPPOMkZ9teDmitLExCKhe8=;
        b=tNwT6LO+aBIZxezXyHnRASPCD62GLFGnjPfwJ8g2r8g/TRw8Eed3jW8Mr3RIogZ1GK
         LV3yahssKSBRFtIammbHYEk9DFeY3VJnnndQdcpBCv8BNoRorXWoTdPo0jdym7Ibkb5N
         7wfT/gUBYpf6rNHAuqW02KsNhsDABS9ODvRTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685401584; x=1687993584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Gwe8KUB75vJ8ATbX2tI7fPPOMkZ9teDmitLExCKhe8=;
        b=d3YIV36rRxHN8s6nJY1gBO7Q+Rht/nlB9hgJI9FjZ5TGy9/byFfO3C/F2oqpRK7GAo
         6N2loTCQ9qHqSnBj63vzgGp/RqkvXoUlCK/qxzyhsfxGwm8Dd9j6H9erWBTjA8c4lSau
         CGEvxS1LrlGJEhENzly9EjOBOhGt6JtJ5pEwohDrQYBrp1G3gwWeax23fpgLZjp/giJ0
         4XIIOCCJaN/RfeUlBykUzx6nzOSvK4j/nAKL2pfUKqMdmc4MGXlrZD9G+ymkmN9l23hB
         yyxabdts22kOCc3MpbBNDGrvfFTSSaRfaB5sLEBW+L3KbDqZIvXYSXoihdcDopXXNJRV
         dm8w==
X-Gm-Message-State: AC+VfDxTXYIDD5SY5iJx5YMWO6UKnvKzhA09fV7HMraG5NxvV5u0Y3Nw
        gGxLBcPbumJX8kofxSVHuPDVmMEhESUlR1Scqf0KIw==
X-Google-Smtp-Source: ACHHUZ623hQPNTMKC8Mr+SxOf2Iq+N2p2KsAbHuoVF1m+4I3MNXJmYskMwlOFEzNpnrSomnbqrVXBWmKsXaAX/RpJ5I=
X-Received: by 2002:a0d:d688:0:b0:559:d39e:e1e8 with SMTP id
 y130-20020a0dd688000000b00559d39ee1e8mr351868ywd.44.1685401583855; Mon, 29
 May 2023 16:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230517144144.365631-1-romain.perier@gmail.com>
 <20230517144144.365631-2-romain.perier@gmail.com> <20230529224039a7f270b9@mail.local>
In-Reply-To: <20230529224039a7f270b9@mail.local>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 30 May 2023 08:06:13 +0900
Message-ID: <CAFr9PX=NmgX5Ww55bz+oM15fhqofFQH=PGs_T6Gkfs4g8ZrFXw@mail.gmail.com>
Subject: Re: [PATCH 1/3] rtc: Add support for the SSD20xD RTC
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Romain Perier <romain.perier@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Alexandre,

On Tue, 30 May 2023 at 07:40, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hello,
>
> On 17/05/2023 16:41:42+0200, Romain Perier wrote:
> > Newer SigmaStar SSD20xD SoCs contain a really low power RTC (300uA claimed),
>
> The low power RTCs are more on the side of a few tenth of nA. RV3028
> consumes 40nA, including the crystal. AB1805 consumes 14nA with an RC
> oscillator. It is funny how SoC vendors think they are low power ;)

To be fair to them I think the 300uA claim is for the whole SoC in
RTC-only deep sleep.
Whatever logic is powered on alongside the RTC to trigger wake up will
be part of that number I guess.

Cheers,

Daniel
