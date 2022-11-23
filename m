Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9509C4332F
	for <linux-rtc@archiver.kernel.org>; Wed, 23 Nov 2022 07:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiKWHI7 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 23 Nov 2022 02:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbiKWHI6 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 23 Nov 2022 02:08:58 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1F30F2418;
        Tue, 22 Nov 2022 23:08:57 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 156C080F1;
        Wed, 23 Nov 2022 07:08:57 +0000 (UTC)
Date:   Wed, 23 Nov 2022 09:08:55 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Matt Ranostay <mranostay@ti.com>
Cc:     michael@walle.cc, vigneshr@ti.com, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, a.zummo@towertech.it,
        linus.walleij@linaro.org, lee@kernel.org, brgl@bgdev.pl,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: mfd: ti,tps6594: add TPS6594 PMIC
 support
Message-ID: <Y33HB/xdCCcStM3V@atomide.com>
References: <20221123053512.1195309-1-mranostay@ti.com>
 <20221123053512.1195309-2-mranostay@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123053512.1195309-2-mranostay@ti.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

* Matt Ranostay <mranostay@ti.com> [221123 05:35]:
> Add documentation for the TPS6594 PMIC including its RTC and GPIO
> functionalities.

Reviewed-by: Tony Lindgren <tony@atomide.com>
