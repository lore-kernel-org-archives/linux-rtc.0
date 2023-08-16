Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDE6C41513
	for <linux-rtc@archiver.kernel.org>; Wed, 16 Aug 2023 23:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbjHPXAR (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 16 Aug 2023 19:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347066AbjHPW74 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 16 Aug 2023 18:59:56 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9468813E;
        Wed, 16 Aug 2023 15:59:55 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1A791C0008;
        Wed, 16 Aug 2023 22:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692226794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1RAqJA3nia0n/RoN7oqkV5CPbD8fsO0klAfE9S0KiOg=;
        b=hETFtkfp+IV6bjHUzFBkSTqPJuC+Xc4B4ZoJ+Es7IfMD4zK2yN6+lxuOX0pGkSYLSSauW+
        lkf6DFUAHXvqDFb97zbjV3nugxToqgoU0gZwjHmNoUIWjUIUt+fRcK4HZUv7/h+SqWWrxp
        v/Sjaq1O5qbzL7Xvnl+GR7aqmekVJfoZR7crgXPeCwfHizIc0iU1KvEPBJYCavZW5cWjFB
        lXxiC8oEyKtlvsmfZQui+bIchMTfsLtOjLdR2eYUOezrvdPrqAom7NbZlbjYVMELFndlvv
        4EcILFBrbO2SZh8xSMKEcQTQVr7qzjxuw6z0okJuvT4/v5S7sdgim94HSKekfQ==
Date:   Thu, 17 Aug 2023 00:59:52 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf2127: fix error code in pcf2127_enable_ts()
Message-ID: <169222675333.114156.11274189629790497651.b4-ty@bootlin.com>
References: <55b9c84b-9d21-444f-b91a-cf9316b65833@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55b9c84b-9d21-444f-b91a-cf9316b65833@moroto.mountain>
X-GND-Sasl: alexandre.belloni@bootlin.com
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org


On Mon, 31 Jul 2023 17:09:30 +0300, Dan Carpenter wrote:
> This error path accidentally returns success.  Return -EINVAL instead.
> 
> 

Applied, thanks!

[1/1] rtc: pcf2127: fix error code in pcf2127_enable_ts()
      commit: 4e5eb7ef73c4c45e2e621eb51a76565153b63afe

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
