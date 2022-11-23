Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47087C4321E
	for <linux-rtc@archiver.kernel.org>; Wed, 23 Nov 2022 07:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbiKWHJx (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 23 Nov 2022 02:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbiKWHJu (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 23 Nov 2022 02:09:50 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49F66F2418;
        Tue, 22 Nov 2022 23:09:50 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BC29A816A;
        Wed, 23 Nov 2022 07:09:49 +0000 (UTC)
Date:   Wed, 23 Nov 2022 09:09:48 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Matt Ranostay <mranostay@ti.com>
Cc:     michael@walle.cc, vigneshr@ti.com, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, a.zummo@towertech.it,
        linus.walleij@linaro.org, lee@kernel.org, brgl@bgdev.pl,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v5 2/4] mfd: tps6594: Add support for TPS6594 PMIC devices
Message-ID: <Y33HPFcN7MNc2w40@atomide.com>
References: <20221123053512.1195309-1-mranostay@ti.com>
 <20221123053512.1195309-3-mranostay@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123053512.1195309-3-mranostay@ti.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

* Matt Ranostay <mranostay@ti.com> [221123 05:36]:
> From: Keerthy <j-keerthy@ti.com>
> 
> The TPS6594 chip is a PMIC, and contains the following components:
> 
> - GPIO controller
> - RTC

Looks nice to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>
