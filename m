Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003DDC433FE
	for <linux-rtc@archiver.kernel.org>; Tue, 17 May 2022 22:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiEQWQU (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 17 May 2022 18:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiEQWQT (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 17 May 2022 18:16:19 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043B92DAAB;
        Tue, 17 May 2022 15:16:17 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4ED651BF203;
        Tue, 17 May 2022 22:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652825776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cfX4azjW5OFE3zvxxzGxiuFXfRPKuMGG4XlvADcXQw4=;
        b=TNDcnlTo/2BV74wA/DX/kuRTV6++ITezUQroIgBjtO3vNjOAhj6wOfTrbYvIQZVnD8Rmc9
        +Jokef60y5BoE7NQ83c6cvsEBiiZaOZbYN8x8DwG2cGohm63VtFztrJcduMearf9GVDSZE
        ygSkPv8jHexo6aUAs/Vp/ykwYRbhPwGdVe3z5wYciWw/syaGxQ77wT93H8WJ9uHnvVJcZU
        Jmmj/aMPqSpFyVA5Z2rADqjuzgKtMbnoRJMRb3+tgwucLeJwhxwRa9TevBznVh34J9DFgW
        fZjd+ZI/J9WdgtHZ3QmzfNVSwl71jwY4ECwMndCGTMloevTKQUvAvlPTtPSLQg==
Date:   Wed, 18 May 2022 00:16:16 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 1/2] dt-binding: pcf85063: Add an entry for pca85073a
Message-ID: <165282575971.293937.2085486603563466593.b4-ty@bootlin.com>
References: <20220419014445.341444-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419014445.341444-1-festevam@gmail.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 18 Apr 2022 22:44:44 -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> The PCA85073A RTC has the same programming model as the PCF85063A.
> 
> Add a compatible entry for it.
> 
> 
> [...]

Applied, thanks!

[1/2] dt-binding: pcf85063: Add an entry for pca85073a
      commit: bb9b98071eacc5f195fe3e7cb0c7664df4cff60f
[2/2] rtc: pcf85063: Add a compatible entry for pca85073a
      commit: aabfe05a824585f64a0620f131841f12ee259a20

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
