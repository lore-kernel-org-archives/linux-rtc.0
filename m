Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89FDC433F5
	for <linux-rtc@archiver.kernel.org>; Wed,  9 Feb 2022 04:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbiBIEHn (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 8 Feb 2022 23:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346244AbiBIDXK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 8 Feb 2022 22:23:10 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E92C06174F;
        Tue,  8 Feb 2022 19:23:10 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id 4so1177269oil.11;
        Tue, 08 Feb 2022 19:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f92doyI4WS5GEh1VL10C5XTr+YtncMIasI2cH1jtcsQ=;
        b=49QR7AGlvAMSjIGZcgi6j3+qpzjVKk+0kiyFD+bmlnERhVh6S0rqhPWwLPTRE+2QG7
         oqiAdTKaJ4TdHpRuDR3cigEROvE0F/NhjozTgzSDurHJ02WQJ158GPmMIswn4mgY3mRF
         c1dHNO/JnK8d5H+wj/C4YLhFzmGi9sQOxWlvHiBwC5FEKCsK/OPjZ8eQ++qaNXFRHAmE
         0YLMj4HeI8Bx8nX1GuX20Qa7jax5qMfT0r0BcSCug0lUDsSySFnhZr1m0ZSE3fuIPwKu
         Q93GValt35mP7qY5hrTbTk93HzShwPn83z5EDxUnln+iRxoX/1IOcUJJU+w1zBrZY6qd
         e62Q==
X-Gm-Message-State: AOAM53258IkIX6Hkl+2c7b2/0Bn6obFS2Xesr1hXeNbtwAXmq4iTClzk
        EcnC+lzDbSmUxP2I4Z704XSCskX5Ag==
X-Google-Smtp-Source: ABdhPJwujgQMIdsO85K6t/UdNoSz/OAClluGz42Rzt3bWWIapEt9ZM75U0CNFs9qXWJJN06apjKJyw==
X-Received: by 2002:a05:6808:693:: with SMTP id k19mr110030oig.165.1644376989580;
        Tue, 08 Feb 2022 19:23:09 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s11sm5881208otq.69.2022.02.08.19.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:23:08 -0800 (PST)
Received: (nullmailer pid 3571792 invoked by uid 1000);
        Wed, 09 Feb 2022 03:23:07 -0000
Date:   Tue, 8 Feb 2022 21:23:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] dt-bindings: rtc: pcf2127: add PCF2131
Message-ID: <YgMzmzMemyUGHLON@robh.at.kernel.org>
References: <20220125200009.900660-1-hugo@hugovil.com>
 <20220125200009.900660-10-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125200009.900660-10-hugo@hugovil.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, Jan 25, 2022 at 03:00:08PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add support for new NXP RTC PCF2131.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../devicetree/bindings/rtc/nxp,pcf2127.yaml  | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
