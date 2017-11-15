Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53178 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756727AbdKOQBs (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 15 Nov 2017 11:01:48 -0500
Date: Wed, 15 Nov 2017 17:01:36 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Baolin Wang <baolin.wang@spreadtrum.com>
Cc: a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, broonie@kernel.org,
        baolin.wang@linaro.org
Subject: Re: [PATCH v3 2/2] rtc: sprd: Add Spreadtrum RTC driver
Message-ID: <20171115160136.yopwad4hfcg5zfhr@piout.net>
References: <c65b61e5e37cb43214973cb3e479ce06c4a73395.1510198341.git.baolin.wang@spreadtrum.com>
 <1e1ee941cc59375627712c0e77036ff36389bb33.1510198341.git.baolin.wang@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1e1ee941cc59375627712c0e77036ff36389bb33.1510198341.git.baolin.wang@spreadtrum.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 09/11/2017 at 11:34:17 +0800, Baolin Wang wrote:
> This patch adds the Spreadtrum RTC driver, which embedded in the
> Spreadtrum SC27xx series PMICs.
> 
> Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>
> ---
> Changes since v2:
>  - Add checking if RTC values are valid.
> 
> Changes since v1:
>  - Change file name.
>  - Should depend on the MFD parent.
>  - Add more help documentation.
>  - Remove regmap wrapper functions.
>  - Modify the mothod of setting alarm.
>  - Remove set_mmss64() method.
>  - Remove checking RTC power-down.
>  - Optimize lock/unlock alarm.
> ---
>  drivers/rtc/Kconfig      |   11 +
>  drivers/rtc/Makefile     |    1 +
>  drivers/rtc/rtc-sc27xx.c |  662 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 674 insertions(+)
>  create mode 100644 drivers/rtc/rtc-sc27xx.c
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
