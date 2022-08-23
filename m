Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78F3C32772
	for <linux-rtc@archiver.kernel.org>; Tue, 23 Aug 2022 20:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiHWUnD (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 23 Aug 2022 16:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiHWUms (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 23 Aug 2022 16:42:48 -0400
X-Greylist: delayed 280 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Aug 2022 13:34:20 PDT
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0998495AE;
        Tue, 23 Aug 2022 13:34:19 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E16C71BF208;
        Tue, 23 Aug 2022 20:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661286858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cV2NYGANONs+McSZvth2jIIUoxYHU0k9OlnO5k/fti8=;
        b=g9GRFiJZXQBWjLSL7fa3c+GxOy35rFp7co+wXhz2QxRHKdudxe9b4gGUYUJd1m5DSwBhjI
        k3JXP7zsNIuosPyqVimmgIlb4HE1dATEZThoRQRpHWVWEw7nSKiBNwEXJWePeOco1v2eS6
        77jpYArCbpvNqfhLI8mt9xmj0lFZdNfoKjAV+LcGoH01u+rp70LU5/WTYWzYc4gMS9L/+2
        eSam3+3tiBbWaf+A+2RovwLNj4QRemNqiWHItiifJsYWkbzeWIOuAf+T/17JVgi1mLL8C4
        OnP17U+Cv+LG1DBiEeBVOKKtt3xHof4uFmTeIaAm2G2dlWenTx2NHs841r0uWA==
Date:   Tue, 23 Aug 2022 22:34:17 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, christophe.jaillet@wanadoo.fr
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: mxc: Use devm_clk_get_enabled() helper
Message-ID: <166128682527.2843313.7668943064097862489.b4-ty@bootlin.com>
References: <1b5ad1877304b01ddbba73ca615274a52f781aa2.1660582728.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b5ad1877304b01ddbba73ca615274a52f781aa2.1660582728.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 15 Aug 2022 18:59:23 +0200, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code, the error handling paths and avoid the need of
> a dedicated function used with devm_add_action_or_reset().
> 
> [...]

Applied, thanks!

[1/1] rtc: mxc: Use devm_clk_get_enabled() helper
      commit: 25bcfaad5ec4e82aede4270d4925967f8520d4cf

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
