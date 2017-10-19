Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:44422 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbdJSKOH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 19 Oct 2017 06:14:07 -0400
Date: Thu, 19 Oct 2017 12:13:49 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sean Wang <sean.wang@mediatek.com>
Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>, a.zummo@towertech.it,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] rtc: mediatek: add driver for RTC on MT7622 SoC
Message-ID: <20171019101349.bo3wwj7mdfdmkdxs@piout.net>
References: <cover.1508231935.git.sean.wang@mediatek.com>
 <2f86eebfd380cf932808df3404e2f4a6f2f0f874.1508231935.git.sean.wang@mediatek.com>
 <1508325126.13340.25.camel@mtksdaap41>
 <20171018125743.kqna6b4lgng674om@piout.net>
 <1508381749.21840.123.camel@mtkswgap22>
 <20171019090219.2odtq3xosqk5ytsb@piout.net>
 <1508407479.29850.5.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1508407479.29850.5.camel@mtkswgap22>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 19/10/2017 at 18:04:39 +0800, Sean Wang wrote:
> I prefer to 2001 to 2099 only which can be completely handled in the
> common logic. Extra specific logic simply for 2100 seems not be
> worthwhile. 
> 

Agreed.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
