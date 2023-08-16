Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3A6C27C53
	for <linux-rtc@archiver.kernel.org>; Wed, 16 Aug 2023 23:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjHPXRC (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 16 Aug 2023 19:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243898AbjHPXQl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 16 Aug 2023 19:16:41 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1F41FD0;
        Wed, 16 Aug 2023 16:16:39 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A28F2240003;
        Wed, 16 Aug 2023 23:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692227797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9MNHp+DZRHMKkAmzptdpSH5KkQPXokWmV5WR4tcAlYk=;
        b=UWkNqIyu2aivCuCwMmA8uXBvYjXBLgZaZC7DQHGmy8mYXxUIQ/TdLqDhWJDMVwtTrAMmQV
        I5ZwFfpDt6JqSLVk/CKDuweQiJ5th0HiSs5Bmghj2/cD3lS/Lbe9uJZW5r8MzCOT4/fa9P
        V6GiMOK6az8kLyD5p2xTeRdid1J3pRYURcTA1qDE4c9FgnqGV78fqk3ixs66TD+DNZUyGs
        NkgL5H22yjl21AXSPyyFxTw05uWsn4wN+OKVelFNggg3Eh0LLU0G5vUNoD+g0zcv6IuQGv
        vB1y18ZdgTQLT0Z+6thmsiBXCheRa8IdMawViQc2M1J8fB2PJ/E/Y3T+TiZRxQ==
Date:   Thu, 17 Aug 2023 01:16:33 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Varshini Rajendran <varshini.rajendran@microchip.com>
Subject: Re: (subset) [PATCH v3 23/50] dt-bindings: rtc: at91rm9200: add
 sam9x7 compatible
Message-ID: <169222778127.125583.3606477911048247590.b4-ty@bootlin.com>
References: <20230728102710.266457-1-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728102710.266457-1-varshini.rajendran@microchip.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org


On Fri, 28 Jul 2023 15:57:10 +0530, Varshini Rajendran wrote:
> Add compatible for SAM9X7 RTC.
> 
> 

Applied, thanks!

[23/50] dt-bindings: rtc: at91rm9200: add sam9x7 compatible
        commit: 0197a7cb44872e49919b0068a512aaf4e06f1850

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
