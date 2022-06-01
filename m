Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35804C433EF
	for <linux-rtc@archiver.kernel.org>; Wed,  1 Jun 2022 21:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiFAVU0 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 1 Jun 2022 17:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiFAVUZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 1 Jun 2022 17:20:25 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37A270342
        for <linux-rtc@vger.kernel.org>; Wed,  1 Jun 2022 14:20:21 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F2552240005;
        Wed,  1 Jun 2022 21:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654118420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sSlDB3gnzPhu7IFK/NzV5c+v5zwrabqJEk+GJGbg4WY=;
        b=LRWx594nTqjjN/q9EkuELLcKRnW4rjHIFDbzYmednlfwdm50kpta/1EL56jwdL7FoJhkkE
        2mnG9iXDLhurMvbAF2T3BhVTm+SvwS/aGHo0HWRx9QFnPmJQkU/ToRjIu3zauEwGWAkCfJ
        3SMoL23dppe+IFbhVCV2hh272usHuaIGb+hEsavJjN6GnBpoWK3BReQSmsCzUotXvWFhAa
        T2sRX34EvmWsP1+oQHpV3tsYben1fD4eNwftkLODWf/PG5JUmTiBZufWdyDgkOH3W3Hcp8
        SToWMScoG7+G5F8kCrwp87YrT4DWhsJ5M3iozfvXADyCA1L6tSBcGDrLoDUj/Q==
Date:   Wed, 1 Jun 2022 23:20:17 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, linux-rtc@vger.kernel.org,
        nathan@kernel.org
Subject: Re: [PATCH] rtc: mxc: Silence a clang warning
Message-ID: <165411839612.796022.11028632602319778983.b4-ty@bootlin.com>
References: <20220526011459.1167197-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526011459.1167197-1-festevam@gmail.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, 25 May 2022 22:14:59 -0300, Fabio Estevam wrote:
> Change the of_device_get_match_data() cast to (uintptr_t)
> to silence the following clang warning:
> 
> drivers/rtc/rtc-mxc.c:315:19: warning: cast to smaller integer type 'enum imx_rtc_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> 
> 

Applied, thanks!

[1/1] rtc: mxc: Silence a clang warning
      commit: f78e3d407a339ffdd2620140300f821ea41118f4

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
