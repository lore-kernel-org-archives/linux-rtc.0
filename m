Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB7F4B0487;
	Thu,  6 Aug 2026 23:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786060440; cv=none; b=tIBewKiZMp6hD2mQ74TdiU2TeOXslegNDiVFh7TTOxmk99tK44zTGVpTjZe3XvuOYYjLhAWXJMTUgc0zePV7jQD/26WdUZOq2Dx5LogFfKGwciUlC27cBhJxOt5/ZA+BVE5I3AF7KyT1n5uaHbZms/2/hx2Y4voWvjjTvWxwO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786060440; c=relaxed/simple;
	bh=/3dtw67vD9ciTaDenOeXdxPvxlJT6KaHAqTMwtdCfNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0ulPkWZ+f2WIMkQal1dCXEznhhq+xX69pYabrkVuEZ8b4vnkklbCKXg8SXFtpOLMFx5wbG3GqvH4/0cEJ43QKqGkO9A0Qt8Qk6yk6gL8olXdZCADnAvXMstYbKvaZJ0dGGV6JsOs78YgfsiuYdwzNaScsFXioVgayIFvOHF55c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzECLiRN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzECLiRN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAF81F000E9;
	Thu,  6 Aug 2026 23:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786060438;
	bh=QDPBmtFsruRFhb6JGsdW/PSu4MccCuWsB88nHyiUJik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TzECLiRN3YmUp8Vkv35V4FByPc22rY+4vrwfz6f/o6oBUH9Ip2/S7EXP+97D0HFc1
	 mQaCxV/lg5KA7x9XaHnp84DU2uKWt0LKyJff0vT4YHUqFZ8ogemfY/EFVlNlGjjtxS
	 8+i/Hi/KrY6Qo0axTISYH/Tr4TDWCHmc/bZq1oO9u6hTIPRjtBjF5LEpjL+el/wkYM
	 qI1h/G29qcWoL3OCCRKYge28mRwVIwN9rRVHFEJmK0YXEdvKaYGHILKtegAP+aL8s6
	 30jZl2pqX04N+j3psXy8YMBsB1O+9VhhxyjFwIijl1l/8AKnfklxZmW5104hOJMn/P
	 jOXb3A1jZK+9A==
Date: Thu, 6 Aug 2026 18:53:54 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Raj Aryan <raryan@qti.qualcomm.com>
Subject: Re: [PATCH 2/2] rtc: qcom: rtc-glink: Add PMIC GLINK RTC driver and
 extend pmic_glink
Message-ID: <anUTc79xyUZthaB6@baldur>
References: <20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com>
 <20260807-rtc-glink-cleanup-v1-2-7801e4d69c4f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-rtc-glink-cleanup-v1-2-7801e4d69c4f@oss.qualcomm.com>

On Fri, Aug 07, 2026 at 02:26:31AM +0530, Kamal Wadhwa wrote:
> Add a new RTC driver that communicates with the PMIC firmware over
> the GLINK transport layer. The driver supports reading time and
> alarm functionality via GET_PROPERTY and SET_PROPERTY opcodes.

Please review the second sentence here, it doesn't match the
implementation.

In fact,
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
says that your commit message should "describe your problem" and nowhere
in this commit message is it described why this patch exists. This is
just regurgitating the code.

N.B. There are no valid problem descriptions that starts with the word
"Add"...

> 
> Time is read via GET_PROPERTY (opcode 0x62) using QCOM_RTC_GLINK_TIME
> property (0x00). Alarm set and enable are handled via SET_PROPERTY
> (opcode 0x63) using QCOM_RTC_GLINK_ALARM and QCOM_RTC_GLINK_ALARM_ENABLE
> properties respectively.
> 

In both of these paragraphs you talk about reading time (and presumably
set/get alarm) - but you do implement rtc_class_ops::set_time, what's up
with that?

> GET_PROPERTY and SET_PROPERTY responses share the same firmware message
> layout, with the firmware echoing back the property value. Both opcodes
> are handled by a common callback path accordingly.
> 

That's true, but it's capturing one detail of the implementation. I
don't think it's relevant in the commit message.

> Also extend pmic_glink to register the RTC as a PMIC GLINK client and
> add PMIC GLINK RTC client support for glymur.
> 

The fact that those 22 lines of code is for a complete separate
subsystem/maintainer and that there isn't a build-time dependency means
that it would be much nicer if it came as separate commits.

The PMIC_GLINK_OWNER_RTC define can be carried in the rtc driver.

> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Raj Aryan <raryan@qti.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Who wrote this driver? The author seems to be you Kamal, but the first
one to sign off on the work was Raj?

> ---
>  MAINTAINERS                         |   7 +
>  drivers/rtc/Kconfig                 |  10 +
>  drivers/rtc/Makefile                |   1 +
>  drivers/rtc/rtc-qcom-glink.c        | 690 ++++++++++++++++++++++++++++++++++++
>  drivers/soc/qcom/pmic_glink.c       |  22 +-
>  include/linux/soc/qcom/pmic_glink.h |   1 +
>  6 files changed, 730 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5f178a5ff026..752cf667b8ad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22505,6 +22505,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
>  F:	drivers/power/supply/qcom_smbx.c
>  
> +QUALCOMM PMIC GLINK RTC DRIVER
> +M:	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> +L:	linux-rtc@vger.kernel.org
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/rtc/rtc-qcom-glink.c
> +
>  QUALCOMM PPE DRIVER
>  M:	Luo Jie <jie.luo@oss.qualcomm.com>
>  L:	netdev@vger.kernel.org
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 01def8231873..3ac39704b2e1 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1836,6 +1836,16 @@ config RTC_DRV_PM8XXX
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rtc-pm8xxx.
>  
> +config RTC_DRV_QCOM_GLINK
> +	tristate "Qualcomm PMIC GLINK RTC"
> +	depends on QCOM_PMIC_GLINK
> +	help
> +	  Say Y here to enable support for the RTC exposed by the PMIC
> +	  over the GLINK transport on Qualcomm platforms.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-qcom-glink.
> +
>  config RTC_DRV_TEGRA
>  	tristate "NVIDIA Tegra Internal RTC driver"
>  	depends on ARCH_TEGRA || COMPILE_TEST
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 0347645b021f..8215a1fc29fb 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -73,6 +73,7 @@ obj-$(CONFIG_RTC_DRV_FM3130)	+= rtc-fm3130.o
>  obj-$(CONFIG_RTC_DRV_FSL_FTM_ALARM)	+= rtc-fsl-ftm-alarm.o
>  obj-$(CONFIG_RTC_DRV_FTRTC010)	+= rtc-ftrtc010.o
>  obj-$(CONFIG_RTC_DRV_GENERIC)	+= rtc-generic.o
> +obj-$(CONFIG_RTC_DRV_QCOM_GLINK) += rtc-qcom-glink.o
>  obj-$(CONFIG_RTC_DRV_GOLDFISH)	+= rtc-goldfish.o
>  obj-$(CONFIG_RTC_DRV_HID_SENSOR_TIME) += rtc-hid-sensor-time.o
>  obj-$(CONFIG_RTC_DRV_HYM8563)	+= rtc-hym8563.o
> diff --git a/drivers/rtc/rtc-qcom-glink.c b/drivers/rtc/rtc-qcom-glink.c
> new file mode 100644
> index 000000000000..611f06a3cc5c
> --- /dev/null
> +++ b/drivers/rtc/rtc-qcom-glink.c
> @@ -0,0 +1,690 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +#include <linux/auxiliary_bus.h>
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/property.h>
> +#include <linux/rtc.h>
> +#include <linux/slab.h>
> +#include <linux/soc/qcom/pdr.h>
> +#include <linux/soc/qcom/pmic_glink.h>
> +#include <linux/timekeeping.h>
> +#include <linux/workqueue.h>
> +
> +#define RTC_GLINK_SET_PROPERTY		0x63
> +#define RTC_GLINK_GET_PROPERTY		0x65
> +#define RTC_GLINK_GET_RTC_TICKS		0x67
> +#define RTC_GLINK_GET_REAL_TIME		0x68
> +#define RTC_GLINK_SET_REAL_TIME		0x69
> +#define RTC_GLINK_ALARM_EXPIRED		0x6A
> +
> +enum qcom_rtc_glink_properties {
> +	QCOM_RTC_GLINK_TIME = 0,
> +	QCOM_RTC_GLINK_ALARM_TIME,
> +	QCOM_RTC_GLINK_ALARM_ENABLE,
> +};

This isn't an enumeration, these are protocol-level constants. Please
use #define to make that clear.

> +
> +struct qcom_rtc_glink_msg {
> +	struct pmic_glink_hdr	hdr;
> +	__le32			property;
> +	__le32			value;
> +};
> +
> +struct qcom_rtc_glink_generic_req {
> +	struct pmic_glink_hdr	hdr;
> +};
> +
> +struct qcom_rtc_glink_status_resp {
> +	struct pmic_glink_hdr	hdr;
> +	__le32			return_status;
> +};
> +
> +struct qcom_rtc_glink_ticks_resp {
> +	struct pmic_glink_hdr	hdr;
> +	__le32			return_status;
> +	__le32			rtc_ticks;
> +};
> +
> +struct qcom_rtc_glink_real_time_resp {
> +	struct pmic_glink_hdr	hdr;
> +	__le32			return_status;
> +	__le32			real_time_data[4];
> +};
> +
> +struct qcom_rtc_glink_set_real_time_req {
> +	struct pmic_glink_hdr	hdr;
> +	__le32			real_time_data[4];
> +};
> +
> +struct qcom_rtc_glink {
> +	struct device		*dev;
> +	struct pmic_glink_client *client;
> +	struct rtc_device	*rtc;
> +
> +	/* Serializes requests: only one may be in flight at a time */
> +	struct mutex		lock;
> +	struct completion	ack;
> +	struct work_struct	alarm_work;
> +
> +	/* Protects service_up and request_pending across callback contexts */
> +	spinlock_t		state_lock;
> +	bool			service_up;
> +	bool			request_pending;
> +
> +	int			error;
> +	u32			resp_value;
> +	u32			offset;
> +	struct rtc_time		resp_tm;
> +	bool			resp_valid;
> +	bool			allow_set_time;
> +};
> +
> +static int qcom_rtc_glink_request(struct qcom_rtc_glink *rtc_glink,
> +				  void *data, size_t len)
> +{
> +	unsigned long flags;
> +	unsigned long left;
> +	int ret;
> +
> +	/*
> +	 * Reinit the completion before request_pending becomes visible to
> +	 * qcom_rtc_glink_pdr_tify(), so a concurrent SSR down-transition
> +	 * can't complete() a stale completion that gets wiped out by
> +	 * reinit_completion() right after.
> +	 */
> +	reinit_completion(&rtc_glink->ack);
> +	rtc_glink->error = 0;
> +	rtc_glink->resp_valid = false;
> +
> +	spin_lock_irqsave(&rtc_glink->state_lock, flags);
> +	if (!rtc_glink->service_up) {
> +		spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> +		return -ECONNRESET;
> +	}
> +	rtc_glink->request_pending = true;
> +	spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> +
> +	ret = pmic_glink_send(rtc_glink->client, data, len);
> +	if (ret < 0) {
> +		spin_lock_irqsave(&rtc_glink->state_lock, flags);
> +		rtc_glink->request_pending = false;
> +		spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> +		return ret;

These 4 lines are effectively duplicated after the
wait_for_completion_timeout(), please refactor this with a goto.

> +	}
> +
> +	left = wait_for_completion_timeout(&rtc_glink->ack, HZ);
> +	spin_lock_irqsave(&rtc_glink->state_lock, flags);
> +	rtc_glink->request_pending = false;
> +	spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> +	if (!left)
> +		return -ETIMEDOUT;
> +
> +	return rtc_glink->error;
> +}
> +
> +static int qcom_rtc_glink_set_property(struct qcom_rtc_glink *rtc_glink,
> +				       u32 property, u32 value)
> +{
> +	struct qcom_rtc_glink_msg msg = {
> +		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_RTC),
> +		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
> +		.hdr.opcode = cpu_to_le32(RTC_GLINK_SET_PROPERTY),
> +		.property = cpu_to_le32(property),
> +		.value = cpu_to_le32(value),
> +	};
> +	int ret;
> +
> +	dev_dbg(rtc_glink->dev,
> +		"TX opcode=0x%x property=%u value=%u\n",
> +		RTC_GLINK_SET_PROPERTY, property, value);
> +	mutex_lock(&rtc_glink->lock);
> +	ret = qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
> +	mutex_unlock(&rtc_glink->lock);
> +	return ret;
> +}
> +
> +static int qcom_rtc_glink_get_property(struct qcom_rtc_glink *rtc_glink,
> +				       u32 property, u32 *value)
> +{
> +	struct qcom_rtc_glink_msg msg = {
> +		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_RTC),
> +		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
> +		.hdr.opcode = cpu_to_le32(RTC_GLINK_GET_PROPERTY),
> +		.property = cpu_to_le32(property),
> +	};
> +	int ret;
> +
> +	dev_dbg(rtc_glink->dev,
> +		"TX opcode=0x%x property=%u\n",
> +		RTC_GLINK_GET_PROPERTY, property);
> +	mutex_lock(&rtc_glink->lock);
> +	ret = qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
> +	if (!ret) {

The idiomatic form in the Linux kernel is to handle the error. I'd find
the following form more natural to read:

	ret = qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
	if (ret < 0) {
		goto out_unlock;
	} else if (!rtc_glink->resp_valid) {
		ret = -EIO;
		goto out_unlock;
	}
	
	*value = rtc_glink->resp_value;

out_unlock:
	mutex_unlock(&rtc_glink->lock);
	return ret;



> +		if (!rtc_glink->resp_valid)
> +			ret = -EIO;
> +		else
> +			*value = rtc_glink->resp_value;
> +	}
> +	mutex_unlock(&rtc_glink->lock);
> +	return ret;
> +}
> +
> +static int qcom_rtc_glink_get_ticks(struct qcom_rtc_glink *rtc_glink,
> +				    u32 *ticks)
> +{
> +	struct qcom_rtc_glink_generic_req msg = {
> +		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_RTC),
> +		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
> +		.hdr.opcode = cpu_to_le32(RTC_GLINK_GET_RTC_TICKS),
> +	};
> +	int ret;
> +
> +	dev_dbg(rtc_glink->dev, "TX opcode=0x%x\n", RTC_GLINK_GET_RTC_TICKS);
> +	mutex_lock(&rtc_glink->lock);
> +	ret = qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
> +	if (!ret) {
> +		if (!rtc_glink->resp_valid)
> +			ret = -EIO;
> +		else
> +			*ticks = rtc_glink->resp_value;
> +	}

Ditto

> +	mutex_unlock(&rtc_glink->lock);
> +	return ret;
> +}
> +
> +static int qcom_rtc_glink_get_real_time(struct qcom_rtc_glink *rtc_glink,
> +					struct rtc_time *tm)
> +{
> +	struct qcom_rtc_glink_generic_req msg = {
> +		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_RTC),
> +		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
> +		.hdr.opcode = cpu_to_le32(RTC_GLINK_GET_REAL_TIME),
> +	};
> +	int ret;
> +
> +	dev_dbg(rtc_glink->dev, "TX opcode=0x%x\n", RTC_GLINK_GET_REAL_TIME);
> +	mutex_lock(&rtc_glink->lock);
> +	ret = qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
> +	if (!ret) {
> +		if (!rtc_glink->resp_valid)
> +			ret = -EIO;
> +		else
> +			*tm = rtc_glink->resp_tm;
> +	}

Ditto.

> +	mutex_unlock(&rtc_glink->lock);
> +	return ret;
> +}
> +
> +static int qcom_rtc_glink_set_real_time(struct qcom_rtc_glink *rtc_glink,
> +					struct rtc_time *tm)
> +{
> +	struct qcom_rtc_glink_set_real_time_req msg = {};
> +	u32 w0, w1;
> +	int ret;
> +
> +	w0 = ((tm->tm_year + 1900) & 0xffff) |
> +	     (((tm->tm_mon + 1) & 0xff) << 16) |
> +	     ((tm->tm_mday & 0xff) << 24);

Can't this be written as:

	w0 = FIELD_PREP(0x0000ffff, tm->tm_year + 1900) |
	     FIELD_PREP(0x00ff0000, tm->tm_mod + 1) |
	     FIELD_PREP(0xff000000, tm->tm_mday);

> +	w1 = (tm->tm_hour & 0xff) |
> +	     ((tm->tm_min & 0xff) << 8) |
> +	     ((tm->tm_sec & 0xff) << 16) |
> +	     (1U << 24);
> +	msg.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_RTC);
> +	msg.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP);
> +	msg.hdr.opcode = cpu_to_le32(RTC_GLINK_SET_REAL_TIME);
> +	msg.real_time_data[0] = cpu_to_le32(w0);
> +	msg.real_time_data[1] = cpu_to_le32(w1);
> +	msg.real_time_data[2] = 0;
> +	msg.real_time_data[3] = 0;
> +	dev_dbg(rtc_glink->dev,
> +		"TX opcode=0x%x data=%08x %08x\n",
> +		RTC_GLINK_SET_REAL_TIME, w0, w1);
> +	mutex_lock(&rtc_glink->lock);
> +	ret = qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
> +	mutex_unlock(&rtc_glink->lock);
> +	return ret;

It certainly wouldn't be bad to insert one or two empty lines in this 28
line block.

> +}
> +
> +static int qcom_rtc_glink_get_time(struct qcom_rtc_glink *rtc_glink,
> +				   struct rtc_time *time)
> +{
> +	u32 ticks;
> +	int ret;
> +
> +	ret = qcom_rtc_glink_get_real_time(rtc_glink, time);
> +	if (!ret)
> +		return 0;
> +	dev_warn(rtc_glink->dev, "0x68 failed (%d), falling back\n", ret);

0x68 failed you say...how about writing an error message that a human
can read?

> +
> +	ret = qcom_rtc_glink_get_ticks(rtc_glink, &ticks);
> +	if (!ret) {
> +		rtc_time64_to_tm((time64_t)ticks + rtc_glink->offset, time);
> +		return 0;
> +	}
> +
> +	ret = qcom_rtc_glink_get_property(rtc_glink, QCOM_RTC_GLINK_TIME,
> +					  &ticks);

Don't wrap lines when they are easier to read in their unwrapped form
and still less than 100 characters.

> +	if (!ret && ticks != U32_MAX) {
> +		rtc_time64_to_tm((time64_t)ticks + rtc_glink->offset, time);
> +		return 0;
> +	}
> +
> +	dev_err(rtc_glink->dev, "all time sources failed\n");
> +	return -EIO;
> +}
> +
> +static int qcom_rtc_glink_set_time(struct qcom_rtc_glink *rtc_glink,
> +				   struct rtc_time *time)
> +{
> +	time64_t t = rtc_tm_to_time64(time);
> +	u32 ticks;
> +	int ret;
> +
> +	if (!rtc_glink->allow_set_time)
> +		return -EOPNOTSUPP;
> +
> +	ret = qcom_rtc_glink_set_real_time(rtc_glink, time);
> +	if (ret)
> +		dev_warn(rtc_glink->dev, "0x69 failed (%d)\n", ret);

Write English error messages.

> +
> +	ret = qcom_rtc_glink_set_property(rtc_glink, QCOM_RTC_GLINK_TIME, (u32)t);
> +	if (ret)
> +		return ret;
> +
> +	ret = qcom_rtc_glink_get_ticks(rtc_glink, &ticks);
> +	if (!ret && ticks != U32_MAX) {
> +		rtc_glink->offset = (u32)t - ticks;

There's no reason to if (success) { dostuff(); } else {return -EIO; }.
Handle the error and then continue with the successful case.

> +	} else {
> +		dev_warn(rtc_glink->dev, "no tick source for offset\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_rtc_glink_set_alarm_en(struct qcom_rtc_glink *rtc_glink,
> +				       int enabled)
> +{
> +	return qcom_rtc_glink_set_property(rtc_glink,
> +					   QCOM_RTC_GLINK_ALARM_ENABLE,
> +					   enabled);
> +}
> +
> +static int qcom_rtc_glink_set_alarm(struct qcom_rtc_glink *rtc_glink,
> +				    struct rtc_wkalrm *alarm)
> +{
> +	time64_t alarm_t = rtc_tm_to_time64(&alarm->time);
> +	struct rtc_time now_tm;
> +	time64_t now_real, secs_until_alarm;
> +	u32 fw_current, fw_alarm;
> +	int ret;
> +
> +	ret = qcom_rtc_glink_get_time(rtc_glink, &now_tm);
> +	if (ret)
> +		return ret;
> +	now_real = rtc_tm_to_time64(&now_tm);
> +	secs_until_alarm = alarm_t - now_real;
> +	dev_dbg(rtc_glink->dev,
> +		"set_alarm: now_real=%lld alarm_t=%lld delta=%lld\n",
> +		now_real, alarm_t, secs_until_alarm);

Here's 12 lines that get the time and calculate now and calculate alarm
time and print a debug message and checks for invalid value.

If you really need the debug print in here, give it a space before and
after to separate it from the actual logic.

> +	if (secs_until_alarm < 0)
> +		return -EINVAL;
> +	if (secs_until_alarm > U32_MAX)
> +		return -ERANGE;
> +
> +	ret = qcom_rtc_glink_get_property(rtc_glink, QCOM_RTC_GLINK_TIME,
> +					  &fw_current);

Again, don't unnecessarily wrap lines that aren't too long.

> +	if (ret)
> +		return ret;
> +	if (fw_current == U32_MAX)
> +		fw_current = 0;
> +	fw_alarm = fw_current + (u32)secs_until_alarm;
> +	dev_dbg(rtc_glink->dev,
> +		"set_alarm: fw_current=%u fw_alarm=%u\n",
> +		fw_current, fw_alarm);
> +
> +	ret = qcom_rtc_glink_set_alarm_en(rtc_glink, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = qcom_rtc_glink_set_property(rtc_glink,
> +					  QCOM_RTC_GLINK_ALARM_TIME, fw_alarm);
> +	if (ret)
> +		return ret;
> +
> +	return qcom_rtc_glink_set_alarm_en(rtc_glink, alarm->enabled);
> +}
> +
> +static int qcom_rtc_glink_get_alarm(struct qcom_rtc_glink *rtc_glink,
> +				    struct rtc_wkalrm *alarm)
> +{
> +	u32 fw_alarm_time, fw_current, alarm_en;
> +	struct rtc_time now_tm;
> +	time64_t now_real, secs_until_alarm, alarm_real;
> +	int ret;
> +
> +	ret = qcom_rtc_glink_get_property(rtc_glink,
> +					  QCOM_RTC_GLINK_ALARM_TIME,
> +					  &fw_alarm_time);
> +	if (ret)
> +		return ret;
> +
> +	ret = qcom_rtc_glink_get_property(rtc_glink, QCOM_RTC_GLINK_TIME,
> +					  &fw_current);
> +	if (ret)
> +		return ret;
> +
> +	ret = qcom_rtc_glink_get_property(rtc_glink,
> +					  QCOM_RTC_GLINK_ALARM_ENABLE,
> +					  &alarm_en);
> +	if (ret)
> +		return ret;
> +	if (fw_current == U32_MAX)
> +		fw_current = 0;
> +
> +	ret = qcom_rtc_glink_get_time(rtc_glink, &now_tm);
> +	if (ret)
> +		return ret;
> +	now_real = rtc_tm_to_time64(&now_tm);
> +	secs_until_alarm = (time64_t)fw_alarm_time - (time64_t)fw_current;
> +	alarm_real = now_real + secs_until_alarm;
> +	dev_dbg(rtc_glink->dev,
> +		"get_alarm: now_real=%lld fw_current=%u fw_alarm=%u delta=%lld\n",
> +		now_real, fw_current, fw_alarm_time, secs_until_alarm);
> +	rtc_time64_to_tm(alarm_real, &alarm->time);
> +	alarm->enabled = !!alarm_en;
> +	return 0;
> +}
> +
> +static void qcom_rtc_glink_alarm_work(struct work_struct *work)
> +{
> +	struct qcom_rtc_glink *rtc_glink =
> +		container_of(work, struct qcom_rtc_glink, alarm_work);
> +	int ret;
> +
> +	ret = qcom_rtc_glink_set_alarm_en(rtc_glink, 0);
> +	if (ret)
> +		dev_err(rtc_glink->dev,
> +			"failed to disable alarm after expiry (%d)\n", ret);
> +	rtc_update_irq(rtc_glink->rtc, 1, RTC_IRQF | RTC_AF);
> +}
> +
> +static void qcom_rtc_glink_callback(const void *data, size_t len, void *priv)
> +{
> +	struct qcom_rtc_glink *rtc_glink = priv;
> +	const struct pmic_glink_hdr *hdr = data;
> +	unsigned long flags;
> +	bool pending;
> +
> +	if (len < sizeof(*hdr))
> +		return;
> +
> +	dev_dbg(rtc_glink->dev,
> +		"RX opcode=0x%x type=0x%x owner=0x%x len=%zu\n",
> +		le32_to_cpu(hdr->opcode), le32_to_cpu(hdr->type),
> +		le32_to_cpu(hdr->owner), len);

I don't fancy all your debug prints, but I love the fact that this isn't
crammed into logical chunks of code.

> +
> +	if (le32_to_cpu(hdr->opcode) == RTC_GLINK_ALARM_EXPIRED) {
> +		dev_info(rtc_glink->dev, "alarm expired\n");

Is this useful to the end user?

> +		schedule_work(&rtc_glink->alarm_work);
> +		return;
> +	}
> +
> +	/*
> +	 * Hold state_lock across the pending check and the response fields
> +	 * below: qcom_rtc_glink_pdr_notify() writes the same error/resp_*
> +	 * fields under this lock when it force-completes a request on an
> +	 * SSR down-transition, and the two must not race. Dropping the
> +	 * response here if !pending also covers requests that already
> +	 * timed out or were aborted; qcom_rtc_glink_request() will call
> +	 * reinit_completion() again before this response could be mistaken
> +	 * for a later request's.
> +	 */
> +	spin_lock_irqsave(&rtc_glink->state_lock, flags);
> +	pending = rtc_glink->request_pending;
> +
> +	if (!pending) {
> +		spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> +		dev_dbg(rtc_glink->dev,
> +			"dropping stale response opcode=0x%x\n",
> +			le32_to_cpu(hdr->opcode));
> +		return;
> +	}
> +
> +	switch (le32_to_cpu(hdr->opcode)) {
> +	case RTC_GLINK_GET_PROPERTY:
> +		fallthrough;
> +	case RTC_GLINK_SET_PROPERTY: {
> +		const struct qcom_rtc_glink_msg *msg = data;
> +
> +		if (len < sizeof(struct pmic_glink_hdr) + sizeof(__le32)) {
> +			rtc_glink->error = -EINVAL;
> +			break;
> +		}
> +		rtc_glink->resp_value = le32_to_cpu(msg->property);
> +		rtc_glink->resp_valid = true;
> +		rtc_glink->error = 0;
> +		dev_dbg(rtc_glink->dev, "ACK opcode=0x%x resp_value=%u\n",
> +			le32_to_cpu(hdr->opcode), rtc_glink->resp_value);
> +		break;
> +	}
> +
> +	case RTC_GLINK_GET_RTC_TICKS: {
> +		const struct qcom_rtc_glink_ticks_resp *resp = data;
> +
> +		if (len < sizeof(*resp)) {
> +			rtc_glink->error = -EINVAL;
> +			break;
> +		}
> +		if (le32_to_cpu(resp->return_status)) {
> +			rtc_glink->error = -EIO;
> +			break;
> +		}
> +		rtc_glink->resp_value = le32_to_cpu(resp->rtc_ticks);
> +		rtc_glink->resp_valid = true;
> +		rtc_glink->error = 0;
> +		dev_dbg(rtc_glink->dev, "ACK opcode=0x%x ticks=%u\n",
> +			RTC_GLINK_GET_RTC_TICKS, rtc_glink->resp_value);
> +		break;
> +	}
> +
> +	case RTC_GLINK_GET_REAL_TIME: {
> +		const struct qcom_rtc_glink_real_time_resp *resp = data;
> +		u32 w0, w1;
> +
> +		if (len < sizeof(*resp)) {
> +			rtc_glink->error = -EINVAL;
> +			break;
> +		}
> +		if (le32_to_cpu(resp->return_status)) {
> +			rtc_glink->error = -EIO;
> +			break;
> +		}
> +		w0 = le32_to_cpu(resp->real_time_data[0]);
> +		w1 = le32_to_cpu(resp->real_time_data[1]);
> +		rtc_glink->resp_tm.tm_year = (w0 & 0xffff) - 1900;
> +		rtc_glink->resp_tm.tm_mon = ((w0 >> 16) & 0xff) - 1;
> +		rtc_glink->resp_tm.tm_mday = (w0 >> 24) & 0xff;
> +		rtc_glink->resp_tm.tm_hour = w1 & 0xff;
> +		rtc_glink->resp_tm.tm_min = (w1 >> 8) & 0xff;
> +		rtc_glink->resp_tm.tm_sec = (w1 >> 16) & 0xff;

Can't you FIELD_GET() these?

> +		rtc_glink->resp_valid = true;
> +		rtc_glink->error = 0;
> +		dev_dbg(rtc_glink->dev,
> +			"ACK opcode=0x%x %04d-%02d-%02d %02d:%02d:%02d\n",
> +			RTC_GLINK_GET_REAL_TIME,
> +			rtc_glink->resp_tm.tm_year + 1900,
> +			rtc_glink->resp_tm.tm_mon + 1,
> +			rtc_glink->resp_tm.tm_mday,
> +			rtc_glink->resp_tm.tm_hour,
> +			rtc_glink->resp_tm.tm_min,
> +			rtc_glink->resp_tm.tm_sec);
> +		break;
> +	}
> +
> +	case RTC_GLINK_SET_REAL_TIME: {
> +		const struct qcom_rtc_glink_status_resp *resp = data;
> +
> +		if (len < sizeof(*resp)) {
> +			rtc_glink->error = -EINVAL;
> +			break;
> +		}
> +		rtc_glink->error = le32_to_cpu(resp->return_status) ? -EIO : 0;
> +		dev_dbg(rtc_glink->dev, "ACK opcode=0x%x status=%u\n",
> +			RTC_GLINK_SET_REAL_TIME,
> +			le32_to_cpu(resp->return_status));
> +		break;
> +	}
> +
> +	default:
> +		spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> +		dev_warn(rtc_glink->dev,
> +			 "unhandled RX opcode=0x%x len=%zu\n",
> +			 le32_to_cpu(hdr->opcode), len);
> +		return;
> +	}
> +
> +	spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> +	complete(&rtc_glink->ack);
> +}
> +
> +static void qcom_rtc_glink_pdr_notify(void *priv, int state)
> +{
> +	struct qcom_rtc_glink *rtc_glink = priv;
> +	unsigned long flags;
> +	bool up = (state == SERVREG_SERVICE_STATE_UP);
> +
> +	spin_lock_irqsave(&rtc_glink->state_lock, flags);
> +	rtc_glink->service_up = up;
> +	if (!up && rtc_glink->request_pending) {
> +		rtc_glink->error = -ECONNRESET;
> +		rtc_glink->resp_valid = false;
> +		complete(&rtc_glink->ack);
> +	}
> +	spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> +}
> +
> +static int qcom_rtc_glink_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	return qcom_rtc_glink_get_time(dev_get_drvdata(dev), tm);
> +}
> +
> +static int qcom_rtc_glink_set_time_dev(struct device *dev, struct rtc_time *tm)
> +{
> +	return qcom_rtc_glink_set_time(dev_get_drvdata(dev), tm);
> +}
> +
> +static int qcom_rtc_glink_read_alarm(struct device *dev,
> +				     struct rtc_wkalrm *alrm)
> +{
> +	return qcom_rtc_glink_get_alarm(dev_get_drvdata(dev), alrm);
> +}
> +
> +static int qcom_rtc_glink_set_alarm_dev(struct device *dev,
> +					struct rtc_wkalrm *alrm)
> +{
> +	return qcom_rtc_glink_set_alarm(dev_get_drvdata(dev), alrm);
> +}
> +
> +static int qcom_rtc_glink_alarm_irq_enable(struct device *dev,
> +					   unsigned int enabled)
> +{
> +	return qcom_rtc_glink_set_alarm_en(dev_get_drvdata(dev), enabled);
> +}
> +
> +static const struct rtc_class_ops qcom_rtc_glink_rtc_ops = {
> +	.read_time = qcom_rtc_glink_read_time,
> +	.set_time = qcom_rtc_glink_set_time_dev,
> +	.read_alarm = qcom_rtc_glink_read_alarm,
> +	.set_alarm = qcom_rtc_glink_set_alarm_dev,
> +	.alarm_irq_enable = qcom_rtc_glink_alarm_irq_enable,
> +};
> +
> +static const struct of_device_id qcom_rtc_glink_of_variants[] = {
> +	{ .compatible = "qcom,glymur-pmic-glink" },
> +	{}
> +};
> +
> +static int qcom_rtc_glink_probe(struct auxiliary_device *adev,
> +				const struct auxiliary_device_id *id)
> +{
> +	struct device *dev = &adev->dev;
> +	struct qcom_rtc_glink *rtc_glink;
> +
> +	if (!of_match_device(qcom_rtc_glink_of_variants, dev->parent))
> +		return -ENXIO;

So in order to support this on a new target we should update both the
client_mask and qcom_rtc_glink_of_variants[]?

Why is this needed?

> +
> +	rtc_glink = devm_kzalloc(dev, sizeof(*rtc_glink), GFP_KERNEL);
> +	if (!rtc_glink)
> +		return -ENOMEM;
> +
> +	rtc_glink->dev            = dev;
> +	rtc_glink->allow_set_time = device_property_read_bool(dev->parent,
> +							      "allow-set-time");

Why do we have this property? Why would we not allow time to be set?

Regards,
Bjorn

> +
> +	mutex_init(&rtc_glink->lock);
> +	spin_lock_init(&rtc_glink->state_lock);
> +	init_completion(&rtc_glink->ack);
> +	INIT_WORK(&rtc_glink->alarm_work, qcom_rtc_glink_alarm_work);
> +	dev_set_drvdata(dev, rtc_glink);
> +
> +	rtc_glink->client = devm_pmic_glink_client_alloc(dev,
> +							 PMIC_GLINK_OWNER_RTC,
> +							 qcom_rtc_glink_callback,
> +							 qcom_rtc_glink_pdr_notify,
> +							 rtc_glink);
> +	if (IS_ERR(rtc_glink->client))
> +		return dev_err_probe(dev, PTR_ERR(rtc_glink->client),
> +				     "failed to allocate glink client\n");
> +
> +	pmic_glink_client_register(rtc_glink->client);
> +
> +	device_init_wakeup(dev, true);
> +
> +	rtc_glink->rtc = devm_rtc_allocate_device(dev);
> +	if (IS_ERR(rtc_glink->rtc))
> +		return dev_err_probe(dev, PTR_ERR(rtc_glink->rtc),
> +				     "failed to allocate RTC device\n");
> +
> +	rtc_glink->rtc->ops      = &qcom_rtc_glink_rtc_ops;
> +	rtc_glink->rtc->range_min = 0;
> +	rtc_glink->rtc->range_max = U32_MAX;
> +
> +	return devm_rtc_register_device(rtc_glink->rtc);
> +}
> +
> +static void qcom_rtc_glink_remove(struct auxiliary_device *adev)
> +{
> +	struct qcom_rtc_glink *rtc_glink = dev_get_drvdata(&adev->dev);
> +	/*
> +	 * Nothing left to arm alarm_work after this returns: the glink
> +	 * client (and its callback/pdr_notify) is torn down by devm after
> +	 * .remove() returns, and rtc_update_irq() below still targets a
> +	 * live devm-managed rtc device.
> +	 */
> +	cancel_work_sync(&rtc_glink->alarm_work);
> +}
> +
> +static const struct auxiliary_device_id qcom_rtc_glink_id_table[] = {
> +	{ .name = "pmic_glink.rtc-glink" },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(auxiliary, qcom_rtc_glink_id_table);
> +
> +static struct auxiliary_driver qcom_rtc_glink_driver = {
> +	.name = "qcom_pmic_rtc_glink",
> +	.id_table = qcom_rtc_glink_id_table,
> +	.probe = qcom_rtc_glink_probe,
> +	.remove = qcom_rtc_glink_remove,
> +};
> +
> +module_auxiliary_driver(qcom_rtc_glink_driver);
> +MODULE_DESCRIPTION("Qualcomm PMIC GLINK RTC driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index 3042261578aa..7ee70a31ba15 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -21,6 +21,7 @@ enum {
>  	PMIC_GLINK_CLIENT_BATT = 0,
>  	PMIC_GLINK_CLIENT_ALTMODE,
>  	PMIC_GLINK_CLIENT_UCSI,
> +	PMIC_GLINK_CLIENT_RTC,
>  };
>  
>  struct pmic_glink_data {
> @@ -40,6 +41,7 @@ struct pmic_glink {
>  	struct auxiliary_device altmode_aux;
>  	struct auxiliary_device ps_aux;
>  	struct auxiliary_device ucsi_aux;
> +	struct auxiliary_device rtc_aux;
>  
>  	/* serializing client_state and pdr_state updates */
>  	struct mutex state_lock;
> @@ -341,6 +343,12 @@ static int pmic_glink_probe(struct platform_device *pdev)
>  			goto out_release_altmode_aux;
>  	}
>  
> +	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_RTC)) {
> +		ret = pmic_glink_add_aux_device(pg, &pg->rtc_aux, "rtc-glink");
> +		if (ret)
> +			goto out_release_ps_aux;
> +	}
> +
>  	if (pg->data->charger_pdr_service_name && pg->data->charger_pdr_service_path) {
>  		service = pdr_add_lookup(pg->pdr, pg->data->charger_pdr_service_name,
>  					 pg->data->charger_pdr_service_path);
> @@ -358,6 +366,9 @@ static int pmic_glink_probe(struct platform_device *pdev)
>  	return 0;
>  
>  out_release_aux_devices:
> +	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_RTC))
> +		pmic_glink_del_aux_device(pg, &pg->rtc_aux);
> +out_release_ps_aux:
>  	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
>  		pmic_glink_del_aux_device(pg, &pg->ps_aux);
>  out_release_altmode_aux:
> @@ -384,11 +395,20 @@ static void pmic_glink_remove(struct platform_device *pdev)
>  		pmic_glink_del_aux_device(pg, &pg->altmode_aux);
>  	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
>  		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
> +	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_RTC))
> +		pmic_glink_del_aux_device(pg, &pg->rtc_aux);
>  
>  	guard(mutex)(&__pmic_glink_lock);
>  	__pmic_glink = NULL;
>  }
>  
> +static const struct pmic_glink_data pmic_glink_glymur_data = {
> +	.client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
> +		       BIT(PMIC_GLINK_CLIENT_ALTMODE) |
> +		       BIT(PMIC_GLINK_CLIENT_UCSI) |
> +		       BIT(PMIC_GLINK_CLIENT_RTC),
> +};
> +
>  static const struct pmic_glink_data pmic_glink_adsp_data = {
>  	.client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
>  		       BIT(PMIC_GLINK_CLIENT_ALTMODE) |
> @@ -404,7 +424,7 @@ static const struct pmic_glink_data pmic_glink_soccp_data = {
>  };
>  
>  static const struct of_device_id pmic_glink_of_match[] = {
> -	{ .compatible = "qcom,glymur-pmic-glink", .data = &pmic_glink_soccp_data },
> +	{ .compatible = "qcom,glymur-pmic-glink", .data = &pmic_glink_glymur_data },
>  	{ .compatible = "qcom,kaanapali-pmic-glink", .data = &pmic_glink_soccp_data },
>  	{ .compatible = "qcom,pmic-glink", .data = &pmic_glink_adsp_data },
>  	{}
> diff --git a/include/linux/soc/qcom/pmic_glink.h b/include/linux/soc/qcom/pmic_glink.h
> index 7cddf1027752..11031b06b810 100644
> --- a/include/linux/soc/qcom/pmic_glink.h
> +++ b/include/linux/soc/qcom/pmic_glink.h
> @@ -11,6 +11,7 @@ struct pmic_glink_client;
>  #define PMIC_GLINK_OWNER_BATTMGR	32778
>  #define PMIC_GLINK_OWNER_USBC		32779
>  #define PMIC_GLINK_OWNER_USBC_PAN	32780
> +#define PMIC_GLINK_OWNER_RTC		32784
>  
>  #define PMIC_GLINK_REQ_RESP		1
>  #define PMIC_GLINK_NOTIFY		2
> 
> -- 
> 2.43.0
> 
