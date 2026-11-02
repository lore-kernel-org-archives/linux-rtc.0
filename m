Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660780;
	b=kjC7WDsPxgElgEFKgnfx/NpsH76Os1PSOwKPgBASMKDYpeLRm5kZqIbBAS8xouMWolM2
	 VovTbNeKlcqT5K4YL8wjgJHmFzVsSLbOdQbO29K86v7myzsws/Kyv7vanssnehs9Htocq
	 WZHs0tdBsIimYLVzRBMwxhkCot9qJ9HLBKRXCkTQabrcgqXwrLtrYM0vQxj4ESU2iTMKT
	 MGwzbLV0bcdEw5bZL6EsP2AVU49m67Xm7JUHRST3czkpmDgfjk1t/9rmFQ8BRmR2d+cA7
	 C7tt319GItWUROPJTrEjpKOVwIvu/EEXNQnY0hAQZtdtoiE5lZ0Vrs0jRw2Vfk8STUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660780;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2txIl/dbbexh4Apii+VBnuFBh+7drhyB4qNjNNBkAuk=;
	b=EHh+VfINKSBBcRlW5vimF52uBAnZdNiABmELlTlOvqbeae/+5ZnSq69wkhKhBxB+F43r
	 9NHoQrFOIBlJekFj79ZHtdVKZitYOzHbDfKsaYgHn1bfTQhsi428U//EmUrmbplS6lxBJ
	 ocO29/sqpFfu8F8pra/wzEEoIyzMdVMhG68qWMZNFhMcIuDg63tz3FglxcdI2nepCp9In
	 UsI7fChHlDGL/0Tl1JjA6VOcR3wSs7SP0MiWjcCafsV600Dll9D9gy0CzkFWHPuXyRQoq
	 bejvtlFfqUa/h/FJijjI6/VCB834LImgDMufz0KuZIMs+obJNHC4+KxuJJfIh50iO6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhIAuWF3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA25606A326
	for <linux-rtc@vger.kernel.org>; Mon,  2 Nov 2026 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhIAuWF3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A651F00A1B;
	Mon,  2 Nov 2026 23:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793660779;
	bh=2txIl/dbbexh4Apii+VBnuFBh+7drhyB4qNjNNBkAuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lhIAuWF3bdOfC/Wk/2lzlWqyxnKZEfJ1rHKP/2R0M8/graIuGCMvMUC4jPt57jaTc
	 SBRU58g97CqNe5ILMt0GuMJV1K3v+ba9N/mpwaztbsPOfLluXPd6LcBgkhCb1nwO+r
	 MTpStC7cs0cTiidUE4JPGIvH7QxVydnZz905qFFS21kkX23xI5gMW48Cg83K9Da1EL
	 eQv0YMmW52LlBwXUL3zgdcRqM1XtvUKRuZBvXo1L4Zf7Jt8xHc4NbUKy98gtfMqnS2
	 24XaBc49D+h39K8mrti2IIgh396GXbhgSXkeG+ZmswMqT6VTuXofQjlC7ydjLM9c0z
	 iYdgJsZpJGKdw==
Message-ID: <sashiko-outbox-194313@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] rtc: qcom: rtc-glink: Add new driver to support
 alarms on Glymur & Hamoa boards
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kamal Wadhwa" <kamal.wadhwa@oss.qualcomm.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261103-rtc-glink-cleanup-v2-2-895eb6e8d890@qti.qualcomm.com>
References: <20261103-rtc-glink-cleanup-v2-0-895eb6e8d890@qti.qualcomm.com>
 <20261103-rtc-glink-cleanup-v2-2-895eb6e8d890@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 23:06:18 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] rtc: qcom-glink: permanent -EAGAIN wedge and races in qcom_rtc_gli=
nk_request()
- [High] rtc: qcom-glink: UAF and ERR_PTR dereference on qcom_rtc_glink_pro=
be() failure
- [High] rtc: qcom-glink: u32 wrap-around in qcom_rtc_glink_get_alarm() and=
 set_alarm()
- [High] rtc: qcom-glink: indefinite probe deferral in qcom_rtc_glink_probe=
() with PDR
- [Medium] rtc: qcom-glink: ignored status in qcom_rtc_glink_set_timer_valu=
e()
- [Medium] rtc: qcom-glink: unbalanced device_init_wakeup() on probe error =
and remove
- [Medium] rtc: qcom-glink: returning -EINVAL instead of -ETIME in qcom_rtc=
_glink_set_alarm()
- [Medium] rtc: qcom-glink: premature client unregister in qcom_rtc_glink_r=
emove()
- [Medium] rtc: qcom-glink: wakeup race from deferring rtc_update_irq() to =
workqueue
--

commit 3cad1ec82d81d9d80a30f2fc1c26ef5d59d6afbe
Author: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

rtc: qcom: rtc-glink: Add new driver to support alarms on Glymur & Hamoa bo=
ards

This commit adds the rtc-qcom-glink auxiliary driver under pmic_glink to
support RTC time read/write operations and alarm notifications relayed by
remote firmware on Qualcomm Glymur and Hamoa platforms.

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/ac=
pi-defined-devices

> diff --git a/drivers/rtc/rtc-qcom-glink.c b/drivers/rtc/rtc-qcom-glink.c
> new file mode 100644
> index 0000000000000..b1394b08e28d2
> --- /dev/null
> +++ b/drivers/rtc/rtc-qcom-glink.c

[ ... ]

> +static int qcom_rtc_glink_request(struct qcom_rtc_glink *rtc_glink,
> +				  void *data, size_t len)
> +{
> +	unsigned long flags;
> +	bool timed_out =3D false;
> +	int ret;
> +
> +	/*
> +	 * Reinit the completion before request_pending becomes visible to
> +	 * qcom_rtc_glink_pdr_notify(), so a concurrent SSR down-transition
> +	 * can't complete() a stale completion that gets wiped out by
> +	 * reinit_completion() right after.
> +	 */
> +	reinit_completion(&rtc_glink->ack);
> +	rtc_glink->error =3D 0;
> +	rtc_glink->resp_valid =3D false;
> +
> +	spin_lock_irqsave(&rtc_glink->state_lock, flags);
> +	if (!rtc_glink->service_up || rtc_glink->timed_out) {
> +		spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> +		return !rtc_glink->service_up ? -ECONNRESET : -EAGAIN;
> +	}
> +	rtc_glink->request_pending =3D true;
> +	spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> +
> +	ret =3D pmic_glink_send(rtc_glink->client, data, len);
> +	if (!ret && !wait_for_completion_timeout(&rtc_glink->ack, HZ)) {
> +		ret =3D -ETIMEDOUT;
> +		timed_out =3D true;
> +	}
> +
> +	spin_lock_irqsave(&rtc_glink->state_lock, flags);
> +	rtc_glink->request_pending =3D false;
> +	rtc_glink->timed_out |=3D timed_out;
> +	spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
> +
> +	return ret < 0 ? ret : rtc_glink->error;
> +}

[Severity: High]
As reported by Sashiko on v1 [1], can a timeout in qcom_rtc_glink_request()
permanently wedge the driver into returning -EAGAIN for all subsequent RTC
operations?

When wait_for_completion_timeout() expires, qcom_rtc_glink_request() sets
rtc_glink->timed_out =3D true, and every later call to qcom_rtc_glink_reque=
st()
immediately returns -EAGAIN while rtc_glink->timed_out remains set.
rtc_glink->timed_out is only cleared in qcom_rtc_glink_callback() when a
response arrives while !rtc_glink->request_pending, or in
qcom_rtc_glink_pdr_notify() on a down-transition. If a request times out
because the message was dropped by firmware and no late reply or SSR
down-transition ever occurs (noting that Glymur sets pdr_available =3D fals=
e),
won't rtc_glink->timed_out stay true forever?

In addition, neither qcom_rtc_glink_callback() nor qcom_rtc_glink_pdr_notif=
y()
clears rtc_glink->request_pending under state_lock. If the response or a PDR
down-notification arrives on another CPU right after
wait_for_completion_timeout() returns 0 and before qcom_rtc_glink_request()
re-acquires state_lock:

CPU0                                  CPU1
qcom_rtc_glink_request()
  wait_for_completion_timeout() -> 0
  timed_out =3D true;
                                      qcom_rtc_glink_callback()
                                        spin_lock_irqsave(&state_lock)
                                        pending =3D rtc_glink->request_pend=
ing;
                                        /* pending is true, consumes reply =
*/
                                        spin_unlock_irqrestore(&state_lock)
  spin_lock_irqsave(&state_lock)
  rtc_glink->request_pending =3D false;
  rtc_glink->timed_out |=3D timed_out;
  spin_unlock_irqrestore(&state_lock)

Because CPU1 already consumed the response while request_pending was still
true, no further response will arrive to clear rtc_glink->timed_out. The sa=
me
happens if qcom_rtc_glink_pdr_notify() runs with !up in that window and cle=
ars
rtc_glink->timed_out before CPU0 sets rtc_glink->timed_out |=3D true.

Also, in the early exit path of qcom_rtc_glink_request():

	if (!rtc_glink->service_up || rtc_glink->timed_out) {
		spin_unlock_irqrestore(&rtc_glink->state_lock, flags);
		return !rtc_glink->service_up ? -ECONNRESET : -EAGAIN;
	}

rtc_glink->service_up is re-read after dropping state_lock. If service_up w=
as
false under the lock and qcom_rtc_glink_pdr_notify() sets service_up =3D tr=
ue
before the return expression is evaluated, qcom_rtc_glink_request() returns
-EAGAIN instead of -ECONNRESET, causing qcom_rtc_glink_probe() to fail with
-ENODEV instead of -EPROBE_DEFER.

> +
> +static int qcom_rtc_glink_set_timer_value(struct qcom_rtc_glink *rtc_gli=
nk,
> +					  u32 timer_id, u32 timer_value)
> +{
> +	struct qcom_rtc_glink_set_timer_req msg =3D {
> +		.hdr.owner =3D cpu_to_le32(PMIC_GLINK_OWNER_RTC),
> +		.hdr.type =3D cpu_to_le32(PMIC_GLINK_REQ_RESP),
> +		.hdr.opcode =3D cpu_to_le32(RTC_GLINK_SET_TIMER_VALUE),
> +		.timer_id =3D cpu_to_le32(timer_id),
> +		.timer_value =3D cpu_to_le32(timer_value),
> +	};
> +
> +	dev_dbg(rtc_glink->dev,
> +		"TX opcode=3D0x%x timer_id=3D%u timer_value=3D%u\n",
> +		RTC_GLINK_SET_TIMER_VALUE, timer_id, timer_value);
> +	return qcom_rtc_glink_request(rtc_glink, &msg, sizeof(msg));
> +}

[Severity: Medium]
Does qcom_rtc_glink_set_timer_value() ignore firmware failure statuses
returned in struct qcom_rtc_glink_timer_resp?

The comment above struct qcom_rtc_glink_timer_resp notes that for
RTC_GLINK_SET_TIMER_VALUE, resp->value holds the pass/fail status. However,=
 in
qcom_rtc_glink_callback(), case RTC_GLINK_GET_TIMER_VALUE falls through to
case RTC_GLINK_SET_TIMER_VALUE and unconditionally sets rtc_glink->error =
=3D 0:

	case RTC_GLINK_GET_TIMER_VALUE:
		fallthrough;
	case RTC_GLINK_SET_TIMER_VALUE: {
		const struct qcom_rtc_glink_timer_resp *resp =3D data;
		...
		rtc_glink->resp_value =3D le32_to_cpu(resp->value);
		rtc_glink->resp_valid =3D true;
		rtc_glink->error =3D 0;

And qcom_rtc_glink_set_timer_value() returns qcom_rtc_glink_request() direc=
tly
without inspecting rtc_glink->resp_value or verifying that the response opc=
ode
matched the pending request. Should RTC_GLINK_SET_TIMER_VALUE check
le32_to_cpu(resp->value) and set rtc_glink->error =3D -EIO when non-zero, s=
imilar
to RTC_GLINK_SET_REAL_TIME?

[ ... ]

> +static int qcom_rtc_glink_set_alarm(struct qcom_rtc_glink *rtc_glink,
> +				    struct rtc_wkalrm *alarm)
> +{
> +	time64_t alarm_t =3D rtc_tm_to_time64(&alarm->time);
> +	struct rtc_time now_tm;
> +	time64_t now_real, secs_until_alarm;
> +	u32 fw_current, fw_alarm;
> +	int ret;
> +
> +	ret =3D qcom_rtc_glink_get_time(rtc_glink, &now_tm);
> +	if (ret)
> +		return ret;
> +
> +	now_real =3D rtc_tm_to_time64(&now_tm);
> +	secs_until_alarm =3D alarm_t - now_real;
> +	dev_dbg(rtc_glink->dev, "set_alarm: now_real=3D%lld alarm_t=3D%lld delt=
a=3D%lld\n",
> +		now_real, alarm_t, secs_until_alarm);
> +
> +	if (secs_until_alarm < 0)
> +		return -EINVAL;

[Severity: Medium]
Should qcom_rtc_glink_set_alarm() return -ETIME instead of -EINVAL when the
alarm time has already passed?

In drivers/rtc/interface.c, __rtc_set_alarm() reads the current time, checks
scheduled <=3D now, and then calls rtc->ops->set_alarm(). Because
qcom_rtc_glink_set_alarm() performs another GLINK round-trip via
qcom_rtc_glink_get_time(), the RTC second can tick past alarm_t during that
IPC call.

The callers of __rtc_set_alarm() in drivers/rtc/interface.c
(rtc_timer_enqueue(), rtc_timer_remove(), and rtc_timer_do_work()) check
specifically for -ETIME to expire the timer immediately via rtc->irqwork.
Returning -EINVAL causes rtc_timer_do_work() to drop the timer after retries
without firing it, leaves the next timer unscheduled in rtc_timer_remove(),
and fails 1-second UIE timers in rtc_timer_enqueue(). Also, if
secs_until_alarm =3D=3D 0 when alarm->enabled is true, programming fw_alarm=
 =3D
fw_current + 0 sets an alarm timestamp that expires before the remaining GL=
INK
requests finish.

> +	if (secs_until_alarm > U32_MAX)
> +		return -ERANGE;
> +
> +	ret =3D qcom_rtc_glink_get_timer_value(rtc_glink, QCOM_RTC_GLINK_TIME, =
&fw_current);
> +	if (ret)
> +		return ret;
> +	if (fw_current =3D=3D U32_MAX)
> +		fw_current =3D 0;
> +	fw_alarm =3D fw_current + (u32)secs_until_alarm;
> +	dev_dbg(rtc_glink->dev, "set_alarm: fw_current=3D%u fw_alarm=3D%u\n", f=
w_current, fw_alarm);
> +
> +	ret =3D qcom_rtc_glink_set_alarm_en(rtc_glink, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D qcom_rtc_glink_set_timer_value(rtc_glink, QCOM_RTC_GLINK_ALARM_=
TIME, fw_alarm);
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
> +	ret =3D qcom_rtc_glink_get_timer_value(rtc_glink, QCOM_RTC_GLINK_ALARM_=
TIME, &fw_alarm_time);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D qcom_rtc_glink_get_timer_value(rtc_glink, QCOM_RTC_GLINK_TIME, =
&fw_current);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D qcom_rtc_glink_get_timer_value(rtc_glink, QCOM_RTC_GLINK_ALARM_=
ENABLE, &alarm_en);
> +	if (ret)
> +		return ret;
> +	if (fw_current =3D=3D U32_MAX)
> +		fw_current =3D 0;
> +
> +	ret =3D qcom_rtc_glink_get_time(rtc_glink, &now_tm);
> +	if (ret)
> +		return ret;
> +
> +	now_real =3D rtc_tm_to_time64(&now_tm);
> +	secs_until_alarm =3D (u32)(fw_alarm_time - fw_current);
> +	alarm_real =3D now_real + secs_until_alarm;
> +	dev_dbg(rtc_glink->dev, "get_alarm: now_real=3D%lld fw_current=3D%u fw_=
alarm=3D%u delta=3D%lld\n",
> +		now_real, fw_current, fw_alarm_time, secs_until_alarm);
> +
> +	rtc_time64_to_tm(alarm_real, &alarm->time);
> +	alarm->enabled =3D !!alarm_en;
> +	return 0;
> +}

[Severity: High]
What happens in qcom_rtc_glink_get_alarm() when fw_alarm_time is less than
fw_current, such as at boot when no alarm has been programmed (fw_alarm_time
is 0) or after an alarm has already expired?

Because secs_until_alarm is computed as:

	secs_until_alarm =3D (u32)(fw_alarm_time - fw_current);
	alarm_real =3D now_real + secs_until_alarm;

any negative delta underflows in 32-bit unsigned arithmetic and wraps to a
timestamp roughly 136 years in the future (exceeding rtc->range_max). During
devm_rtc_register_device(), __devm_rtc_register_device() calls
__rtc_read_alarm() and rtc_initialize_alarm(), which relies on comparing the
alarm time against now to ignore already-expired alarms. Wrapping expired
alarms into the future defeats that check and enqueues stale alarms into
rtc->timerqueue.

Conversely, in qcom_rtc_glink_set_alarm(), fw_alarm =3D fw_current +
(u32)secs_until_alarm can overflow 32 bits or land on the U32_MAX sentinel
when secs_until_alarm >=3D U32_MAX - fw_current.

> +
> +static void qcom_rtc_glink_alarm_work(struct work_struct *work)
> +{
> +	struct qcom_rtc_glink *rtc_glink =3D
> +		container_of(work, struct qcom_rtc_glink, alarm_work);
> +
> +	/*
> +	 * The glink client is registered, and can receive an unsolicited
> +	 * ALARM_EXPIRED, before the RTC device exists - e.g. if the board
> +	 * booted because of a previously armed alarm.
> +	 */
> +	if (!rtc_glink->rtc)
> +		return;
> +
> +	rtc_lock(rtc_glink->rtc);
> +	rtc_update_irq(rtc_glink->rtc, 1, RTC_IRQF | RTC_AF);
> +	rtc_unlock(rtc_glink->rtc);
> +}
> +
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
> +		schedule_work(&rtc_glink->alarm_work);
> +		return;
> +	}

[Severity: Medium]
Can deferring rtc_update_irq() to qcom_rtc_glink_alarm_work() race with sys=
tem
suspend when RTC_GLINK_ALARM_EXPIRED arrives during suspend entry or
suspend-to-idle?

The GLINK RX callback runs from the IPCC interrupt handler
(qcom_ipcc_irq_fn() -> qcom_glink_smem_intr() -> qcom_glink_native_rx() ->
pmic_glink_rpmsg_callback() -> qcom_rtc_glink_callback()), and none of the
underlying IPCC, GLINK, or pmic_glink layers activate a wakeup source. When
qcom_rtc_glink_callback() only calls schedule_work(&rtc_glink->alarm_work) =
and
returns from the interrupt handler, pm_stay_awake(rtc->dev.parent) inside
rtc_update_irq() is not called until alarm_work gets scheduled and acquires
rtc_lock(rtc_glink->rtc) (which is also held by rtc_suspend() during
dpm_suspend()).

Since rtc_update_irq() is safe to call from hardirq context, checks
IS_ERR_OR_NULL(rtc), calls pm_stay_awake(rtc->dev.parent) immediately, and
schedules rtc->irqwork (which takes rtc->ops_lock itself), could
qcom_rtc_glink_callback() call rtc_update_irq() directly instead of bouncing
through alarm_work?

[ ... ]

> +static int qcom_rtc_glink_probe(struct auxiliary_device *adev,
> +				const struct auxiliary_device_id *id)
> +{

[ ... ]

> +	pmic_glink_client_register(rtc_glink->client);
> +
> +	ret =3D qcom_rtc_glink_get_time(rtc_glink, &tm);
> +	if (ret) {
> +		pmic_glink_client_unregister(rtc_glink->client);
> +		if (ret =3D=3D -ECONNRESET)
> +			return -EPROBE_DEFER;
> +		return dev_err_probe(dev, -ENODEV,
> +				     "RTC GLINK firmware is not available\n");
> +	}

[Severity: High]
On PDR-enabled platforms such as Hamoa (X1E80100), can returning -EPROBE_DE=
FER
here when ret =3D=3D -ECONNRESET leave the driver permanently on the deferr=
ed
probe list?

In drivers/soc/qcom/pmic_glink.c, pmic_glink_probe() registers the rtc-glink
auxiliary device before pdr_add_lookup() completes and before __pmic_glink =
is
set, so pg->client_state is initially 0 and qcom_rtc_glink_get_time() retur=
ns
-ECONNRESET. On Hamoa (PMIC_RTR_ADSP_APPS), pg->pdr_available is true, so
pg->pdr_state only transitions to SERVREG_SERVICE_STATE_UP asynchronously in
pmic_glink_pdr_callback() from a QMI worker thread. Because
pmic_glink_pdr_callback() only notifies registered clients and does not bin=
d a
device, it does not trigger driver_deferred_probe_trigger(). If
pmic_glink_pdr_callback() runs after device probing has settled, what will
re-trigger probing of qcom_rtc_glink_probe()?

> +
> +	device_init_wakeup(dev, true);

[Severity: Medium]
Does calling unmanaged device_init_wakeup(dev, true) here leak the wakeup
source on probe failure or when the driver is unbound in
qcom_rtc_glink_remove()?

Neither the error paths below nor qcom_rtc_glink_remove() call
device_init_wakeup(dev, false). Should this use devm_device_init_wakeup(dev)
instead?

> +
> +	rtc_glink->rtc =3D devm_rtc_allocate_device(dev);
> +	if (IS_ERR(rtc_glink->rtc)) {
> +		pmic_glink_client_unregister(rtc_glink->client);
> +		return PTR_ERR(rtc_glink->rtc);
> +	}
> +
> +	rtc_glink->rtc->ops =3D &qcom_rtc_glink_rtc_ops;
> +	rtc_glink->rtc->range_min =3D 0;
> +	rtc_glink->rtc->range_max =3D U32_MAX;
> +
> +	return devm_rtc_register_device(rtc_glink->rtc);
> +}

[Severity: High]
As reported by Sashiko on v1 [2], can a probe failure after
pmic_glink_client_register() cause a use-after-free or an ERR_PTR dereferen=
ce
in qcom_rtc_glink_alarm_work()?

Once pmic_glink_client_register() has been called, qcom_rtc_glink_callback()
can receive an unsolicited RTC_GLINK_ALARM_EXPIRED message and schedule
rtc_glink->alarm_work:

1. None of the error paths after pmic_glink_client_register()
   (qcom_rtc_glink_get_time(), devm_rtc_allocate_device(), or
   devm_rtc_register_device()) cancel rtc_glink->alarm_work before devres
   frees rtc_glink.

2. If devm_rtc_allocate_device() fails, rtc_glink->rtc is assigned the ERR_=
PTR
   before the IS_ERR() check and before pmic_glink_client_unregister() is
   called. Because qcom_rtc_glink_alarm_work() only checks if
   (!rtc_glink->rtc), a concurrent work execution will pass that check and
   dereference the ERR_PTR in rtc_lock(rtc_glink->rtc).

3. If devm_rtc_register_device() fails, pmic_glink_client_unregister() is n=
ot
   called at all. Because devm_pmic_glink_client_alloc() was registered bef=
ore
   devm_rtc_allocate_device(), devres releases rtc_glink->rtc before removi=
ng
   the GLINK client, leaving rtc_glink->rtc as a non-NULL dangling pointer
   while callbacks and alarm_work can still run.

> +
> +static void qcom_rtc_glink_remove(struct auxiliary_device *adev)
> +{
> +	struct qcom_rtc_glink *rtc_glink =3D dev_get_drvdata(&adev->dev);
> +
> +	pmic_glink_client_unregister(rtc_glink->client);
> +	cancel_work_sync(&rtc_glink->alarm_work);
> +}

[Severity: Medium]
In qcom_rtc_glink_remove(), pmic_glink_client_unregister() is called before
devres unregisters rtc_glink->rtc, and without clearing rtc_glink->service_=
up.

If an RTC operation or rtc->irqwork (scheduled by qcom_rtc_glink_alarm_work=
()
via rtc_update_irq()) runs while the RTC device is still registered, won't =
it
see rtc_glink->service_up =3D=3D true, send a GLINK request whose response =
can
never arrive, block for HZ until timeout, and cause rtc_timer_do_work() to
bail out on -ETIMEDOUT without calling pm_relax(rtc->dev.parent)?

[1] https://lore.kernel.org/r/20260806210934.485441F000E9@smtp.kernel.org
[2] https://lore.kernel.org/r/20260806210934.485441F000E9@smtp.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-rtc-glink-=
cleanup-v2-0-895eb6e8d890@qti.qualcomm.com?part=3D2
