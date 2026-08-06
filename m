Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B523DA7C8;
	Thu,  6 Aug 2026 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050576; cv=none; b=miw6oDBOOvJQuDTkzXFqY304aX0v81NonBsmBtwxB3O81DR9T4SCxNS0CUXsXzP/ff7wYbBpAzL2WGkUDZ+fcHNvFe7/BThp+CWRnq29B09s/myVO43+WMW3a+KTU/Qi62owYI13eLXwqJ60gKBci7VV1+XeEUtn2OmRZP1utsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050576; c=relaxed/simple;
	bh=elTvhaU8FxNDhGNur77coL/Ik5EZflp2hH6GRxBXZhA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UO2cJg4GKbwrIDKlMSrxMmSxFghGiIFiRmheYIy39TPFKnSSz7Y8VAvJ4dNDZzebrQAoXcToc8kjY+SsvCmjdusAtSnQ06ev8Zv9DqMG22SHa8Hmw8NA967hDvvVfnklPlzATZo3XlqNEOFSPFbC7OyD6gCpI/08KxKa+mJIMUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9Cn+D1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9Cn+D1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485441F000E9;
	Thu,  6 Aug 2026 21:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786050574;
	bh=vqbnknkMqb7T4jVlLTLG6e7fJnj9Z5+0ElZmMjErQ3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U9Cn+D1Kcj91EEf8sNOi/U0c57AgCwoVNGxLkoYi14E2HElDvXZNiABje0ghe+62n
	 ixHu0z7bleLwv6FANCxORmpva4dsfJil/H3RyPyo8DXidQA9iMgUQR2zTGC9jHGcja
	 6DzPbl3uu7Ui5r095uKo+6pdakfJ9gSaqT8NDHmIleJlx18oP7hHPe16ounLQLmoQ8
	 Cnp6xrXtdCsiUddi5u4se+WayESQdwUo5fWZNvIRyTiBN4kxLCsybdobV6ZGj/o5MW
	 3RUEFXCAYECWngGUQ2YyBA1MSRS+ojeF6DAoGCiFX3vCg3d8p8HOhhsIF+g/osWD2Z
	 7Na19aXvhHnrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] rtc: qcom: rtc-glink: Add PMIC GLINK RTC driver and
 extend pmic_glink
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kamal Wadhwa" <kamal.wadhwa@oss.qualcomm.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260807-rtc-glink-cleanup-v1-2-7801e4d69c4f@oss.qualcomm.com>
References: <20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com>
 <20260807-rtc-glink-cleanup-v1-2-7801e4d69c4f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 21:09:33 +0000
Message-Id: <20260806210934.485441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Racy cancellation of alarm_work and incorrect devres teardown orde=
r causes Use-After-Free on driver unbind and probe failure.
- [High] The callback extracts the property ID instead of the property valu=
e for GET_PROPERTY responses, returning the property ID as the time or alar=
m value.
- [High] A timeout in `qcom_rtc_glink_request` leaves the request-response =
state machine out of sync, allowing late firmware responses to hijack subse=
quent requests.
- [High] Corrupted time and alarm calculations via contradictory fallback u=
sage of QCOM_RTC_GLINK_TIME and implicit 64-bit integer promotion.
--

--- Patch [2]: [PATCH 2/2] rtc: qcom: rtc-glink: Add PMIC GLINK RTC driver =
and extend pmic_glink ---
commit 453a7a32b4bd6fbb186e249935eb4448bc3ddd38
Author: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Subject: rtc: qcom: rtc-glink: Add PMIC GLINK RTC driver and extend pmic_gl=
ink

Add a new RTC driver that communicates with the PMIC firmware over the
GLINK transport layer. It supports reading time and alarm functionality via
GET_PROPERTY and SET_PROPERTY opcodes.

> diff --git a/drivers/rtc/rtc-qcom-glink.c b/drivers/rtc/rtc-qcom-glink.c
> new file mode 100644
> index 0000000000000..611f06a3cc5ca
> --- /dev/null
> +++ b/drivers/rtc/rtc-qcom-glink.c
> @@ -0,0 +1,690 @@
[ ... ]
> +static int qcom_rtc_glink_request(struct qcom_rtc_glink *rtc_glink,
> +				  void *data, size_t len)
> +{
> +	unsigned long flags;
> +	unsigned long left;
> +	int ret;
[ ... ]
> +	left =3D wait_for_completion_timeout(&rtc_glink->ack, HZ);
> +	spin_lock_irqsave(&rtc_glink->state_lock, flags);
> +	rtc_glink->request_pending =3D false;
> +	spin_unlock_irqrestore(&rtc_glink->state_lock, flags);

[Severity: High]
If wait_for_completion_timeout() expires, request_pending is cleared. If a
new request is immediately made, request_pending becomes true again.

Could a late firmware response to the previous request arrive and be
mistakenly accepted for the new request, since the callback lacks
transaction ID or opcode validation?

> +	if (!left)
> +		return -ETIMEDOUT;
> +
> +	return rtc_glink->error;
> +}
[ ... ]
> +static int qcom_rtc_glink_get_time(struct qcom_rtc_glink *rtc_glink,
> +				   struct rtc_time *time)
> +{
> +	u32 ticks;
> +	int ret;
[ ... ]
> +	ret =3D qcom_rtc_glink_get_property(rtc_glink, QCOM_RTC_GLINK_TIME,
> +					  &ticks);
> +	if (!ret && ticks !=3D U32_MAX) {
> +		rtc_time64_to_tm((time64_t)ticks + rtc_glink->offset, time);

[Severity: High]
QCOM_RTC_GLINK_TIME is set as an absolute time in qcom_rtc_glink_set_time().

Does adding rtc_glink->offset to it here in the fallback path result in an
incorrect time calculation (Absolute Time + (Absolute Time - Uptime))?

Also, since rtc_glink->offset is a u32, will a negative 32-bit offset be
zero-extended rather than sign-extended when computing
(time64_t)ticks + rtc_glink->offset?

> +		return 0;
> +	}
> +
> +	dev_err(rtc_glink->dev, "all time sources failed\n");
> +	return -EIO;
> +}
[ ... ]
> +static int qcom_rtc_glink_get_alarm(struct qcom_rtc_glink *rtc_glink,
> +				    struct rtc_wkalrm *alarm)
> +{
> +	u32 fw_alarm_time, fw_current, alarm_en;
> +	struct rtc_time now_tm;
> +	time64_t now_real, secs_until_alarm, alarm_real;
> +	int ret;
[ ... ]
> +	ret =3D qcom_rtc_glink_get_time(rtc_glink, &now_tm);
> +	if (ret)
> +		return ret;
> +	now_real =3D rtc_tm_to_time64(&now_tm);
> +	secs_until_alarm =3D (time64_t)fw_alarm_time - (time64_t)fw_current;

[Severity: High]
By casting these 32-bit firmware times to time64_t before subtracting, do we
lose the 32-bit modulo arithmetic?

If the hardware counters wrap, will this produce a large negative delta
instead of the correct positive duration?

> +	alarm_real =3D now_real + secs_until_alarm;
> +	dev_dbg(rtc_glink->dev,
> +		"get_alarm: now_real=3D%lld fw_current=3D%u fw_alarm=3D%u delta=3D%lld=
\n",
> +		now_real, fw_current, fw_alarm_time, secs_until_alarm);
> +	rtc_time64_to_tm(alarm_real, &alarm->time);
> +	alarm->enabled =3D !!alarm_en;
> +	return 0;
> +}
[ ... ]
> +static void qcom_rtc_glink_callback(const void *data, size_t len, void *=
priv)
> +{
> +	struct qcom_rtc_glink *rtc_glink =3D priv;
> +	const struct pmic_glink_hdr *hdr =3D data;
> +	unsigned long flags;
> +	bool pending;
> +
> +	if (len < sizeof(*hdr))
> +		return;
> +
> +	dev_dbg(rtc_glink->dev,
> +		"RX opcode=3D0x%x type=3D0x%x owner=3D0x%x len=3D%zu\n",
> +		le32_to_cpu(hdr->opcode), le32_to_cpu(hdr->type),
> +		le32_to_cpu(hdr->owner), len);
> +
> +	if (le32_to_cpu(hdr->opcode) =3D=3D RTC_GLINK_ALARM_EXPIRED) {
> +		dev_info(rtc_glink->dev, "alarm expired\n");
> +		schedule_work(&rtc_glink->alarm_work);

[Severity: High]
Does this handle the RTC_GLINK_ALARM_EXPIRED opcode and call schedule_work()
unconditionally?

If the driver is actively tearing down, could this run after the device is
freed due to the devres teardown order?

> +		return;
> +	}
[ ... ]
> +	switch (le32_to_cpu(hdr->opcode)) {
> +	case RTC_GLINK_GET_PROPERTY:
> +		fallthrough;
> +	case RTC_GLINK_SET_PROPERTY: {
> +		const struct qcom_rtc_glink_msg *msg =3D data;
> +
> +		if (len < sizeof(struct pmic_glink_hdr) + sizeof(__le32)) {
> +			rtc_glink->error =3D -EINVAL;
> +			break;
> +		}
> +		rtc_glink->resp_value =3D le32_to_cpu(msg->property);

[Severity: High]
For GET_PROPERTY responses, does this assign the property ID (e.g., 0 for
time, 1 for alarm) to resp_value instead of the actual data in msg->value?

Also, the bounds check only validates 16 bytes (sizeof hdr + sizeof
property). Does this need to validate 20 bytes to safely access msg->value?

> +		rtc_glink->resp_valid =3D true;
> +		rtc_glink->error =3D 0;
> +		dev_dbg(rtc_glink->dev, "ACK opcode=3D0x%x resp_value=3D%u\n",
> +			le32_to_cpu(hdr->opcode), rtc_glink->resp_value);
> +		break;
> +	}
[ ... ]
> +	default:
> +		spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> +		dev_warn(rtc_glink->dev,
> +			 "unhandled RX opcode=3D0x%x len=3D%zu\n",
> +			 le32_to_cpu(hdr->opcode), len);
> +		return;
> +	}
> +
> +	spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> +	complete(&rtc_glink->ack);

[Severity: High]
Is it safe to call complete() after dropping state_lock?

Could this create a race window where a preempted callback completes a newly
issued request prematurely?

> +}
[ ... ]
> +static int qcom_rtc_glink_probe(struct auxiliary_device *adev,
> +				const struct auxiliary_device_id *id)
> +{
> +	struct device *dev =3D &adev->dev;
> +	struct qcom_rtc_glink *rtc_glink;
[ ... ]
> +	rtc_glink->client =3D devm_pmic_glink_client_alloc(dev,
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
> +	rtc_glink->rtc =3D devm_rtc_allocate_device(dev);
> +	if (IS_ERR(rtc_glink->rtc))

[Severity: High]
The GLINK client is registered before the RTC device is allocated.

If devm_rtc_allocate_device() fails, or during driver unbind, the GLINK
client remains active while devres unwinds. Could this allow firmware to
trigger qcom_rtc_glink_callback() on a freed rtc_glink structure?

> +		return dev_err_probe(dev, PTR_ERR(rtc_glink->rtc),
> +				     "failed to allocate RTC device\n");
[ ... ]
> +static void qcom_rtc_glink_remove(struct auxiliary_device *adev)
> +{
> +	struct qcom_rtc_glink *rtc_glink =3D dev_get_drvdata(&adev->dev);
> +	/*
> +	 * Nothing left to arm alarm_work after this returns: the glink
> +	 * client (and its callback/pdr_notify) is torn down by devm after
> +	 * .remove() returns, and rtc_update_irq() below still targets a
> +	 * live devm-managed rtc device.
> +	 */
> +	cancel_work_sync(&rtc_glink->alarm_work);

[Severity: High]
Since the GLINK client is managed by devm and hasn't been unregistered yet,
could an incoming ALARM_EXPIRED firmware message re-queue alarm_work
immediately after this cancel_work_sync() completes?

This might lead to a use-after-free when devres subsequently frees the
memory.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-rtc-glink-=
cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com?part=3D2
