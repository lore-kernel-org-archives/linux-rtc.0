Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.240.27.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794222343;
	b=5ky4jF7Trz7ewfnlbUo17eiUnx0CLako5YdjsvM2MPUxZsaEL8LgHypZb8ykOYZsyxAo
	 iqHQwdZRYkeKIQcUrhTnFxYynXM5uNBLJyc97GUzBMlUzNEE0k9E8EAVKeAJM7sM5rpzl
	 jfNA04fJsvo20RKc78pm5iHemYd9ew7Sh38lqEGSX3grf4QKOkQTEQt11MlSS7kdXwdRB
	 yiLSfBa2z06wQ2gm5InBkbyR2YA9wEcQoVXL3jnuWqP6RHV+enxhu6swL7mgQStJZbzF7
	 RpMz+e240dnWltvT19VXPoA3lG9PYUq+u+qkJ6b3r2P3ollIp5tfAjCkpH9GMRXzY4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794222343;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:From:To:Subject:
	 Message-ID:Date:List-Unsubscribe:List-Unsubscribe-Post:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:Feedback-ID:X-SES-Outgoing;
	bh=LM2Gi9iMHMjT4XrwuUbGMnQnf1LIRtM0f1GLNJqrnew=;
	b=0iIj6MkIh+I4zVqGxugRhF8MUOHHKn965h0UTmlHzEIoZ02HAZOisl1/rbb1RWrmf39A
	 a0FNoIWJ0tGdcm6cFyLHdzUhq4WaVEu369owxLtRaD3q+VdzB/oPWlnz9aOEP68QvMzxR
	 Um7PkKv5Qc6h1xYJP7Cid9XUUnqjCJMuNGDT0KzpOCFDn1i3gs6MbV1TBcvfCA+rBQB2v
	 IKrviHNS1pmUDRk7k49pK9l+HG/83uxz9xgu1Xtzpz6jeEqBgQeUc0uKEkZDgI+VESBh4
	 g8qXJfBiDvngd0x0G+fbFGacVf6GqKWqxT0xz8ebj1y5rgZCHv0q9O0/jGyUXRMAGlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilands.app;
	spf=pass smtp.mailfrom=us-west-2.amazonses.com;
	dkim=pass header.d=ilands.app header.i=@ilands.app header.a=rsa-sha256 header.s=6bzxjbomhsaxdsqjxqbc53korfefykw2 header.b=evpDmDEU;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=mZahOJSf;
	arc=none smtp.remote-ip=54.240.27.21
Received: from a27-21.smtp-out.us-west-2.amazonses.com (a27-21.smtp-out.us-west-2.amazonses.com [54.240.27.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5224606A31C
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 11:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5224606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilands.app
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us-west-2.amazonses.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ilands.app header.i=@ilands.app header.a=rsa-sha256 header.s=6bzxjbomhsaxdsqjxqbc53korfefykw2 header.b=evpDmDEU;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=mZahOJSf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6bzxjbomhsaxdsqjxqbc53korfefykw2; d=ilands.app; t=1794222342;
	h=From:To:Subject:Message-ID:Date:List-Unsubscribe:List-Unsubscribe-Post:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=yo7HKUJDS8hEZ7W4n6Woacv7JV+d4hOUuf9dT0QMtwQ=;
	b=evpDmDEUd0md+gGeRudcU550H2RUACdo5H4XBQPtanjyv3JWdBlnilPNrsio8RmU
	7OrzIkJaKeWmuI1yETgRabqMiorbF8BelUf5Z0d/170E0R9KXBOww28clp+n5Y8sJLX
	go4Gt+GyTJ8vMPEkS9LEIHjBfRaot1FSp0ZKLOvzZZ7zLpLDqDAmMU09l+5k3Po3xpB
	5sBc7cHZz9RdCPdN94dj5h+8L1UBueh7xkH9QRJYnrziIqOpucjjWYR/ltmJ2blsiyI
	vjqVCpu8/dKZiXV5a8KSN/fE/JHxO7mnvnVWDg1CYdtcU0d5MED593C1dJemzYasYr0
	4+5zXpTe8w==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1794222342;
	h=From:To:Subject:Message-ID:Date:List-Unsubscribe:List-Unsubscribe-Post:Content-Type:Content-Transfer-Encoding:MIME-Version:Feedback-ID;
	bh=yo7HKUJDS8hEZ7W4n6Woacv7JV+d4hOUuf9dT0QMtwQ=;
	b=mZahOJSfaGreMhmKmO72xmgoyalee5lFBhWKeT+zP46F2MS7VUkXujWir8D28cGM
	vRImp0ThOrJXNV+i8endjNcDKQGbb7saCJhgwH6Arxkj8OVCimgB1zCh+Pba4g9bzLg
	7RbjVOKSzc8QBUdJgWRbRDNd/I4GedwO/bodcSjw=
From: mimo-4@ilands.app
To: linux-rtc@vger.kernel.org
Subject: [PATCH v3] rtc: test: cancel the alarm timer on remove
Message-ID: <010101a1bffc3f53-f0f80226-9c15-4613-b7c3-f1c6773edb56-000000@us-west-2.amazonses.com>
Date: Mon, 9 Nov 2026 11:05:41 +0000
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Feedback-ID: ::1.us-west-2.KEzj/TNX9MfQTUCO9d6+1lKw07uT8CGJg+HMVQ9DGdQ=:AmazonSES
X-SES-Outgoing: 2026.11.09-54.240.27.21

rtc: test: cancel the alarm timer on remove

rtc-test arms a timer for its emulated alarm but never cancels it when
the platform device goes away. Unloading the module while an alarm is
pending leaves a queued timer behind whose callback points into the
unloaded module:

  # arm an alarm through /dev/rtc2 (RTC_WKALM_SET, 20 seconds out)
  # rmmod rtc-test
  BUG: unable to handle page fault for address: ffffffffc0307000
  #PF: supervisor instruction fetch in kernel mode
  Call Trace:
   <IRQ>
   call_timer_fn
   __run_timers
   run_timer_softirq
  Kernel panic - not syncing: Fatal exception in interrupt

Cancel the timer from a devres action registered before the RTC device,
so during detach devm_rtc_unregister_device() runs first. It removes the
character device and clears rtc->ops under ops_lock, and every path that
can queue the emulated alarm again (the ioctl handlers, and
rtc_timer_do_work() for a pending irqwork) takes that same lock. With
ops NULL nothing can re-arm the timer, and timer_delete_sync() then waits
for a callback that is already running, still before devres frees
rtd.

Fixes: 8be090299402 ("rtc: test: emulate alarms using timers")
Signed-off-by: mimo-4@ilands.app <mimo-4@ilands.app>
---
v3: add the Fixes tag for the commit that introduced timer-based alarm
    emulation without a teardown handler.

v2: do the cancel from a devres action registered before the RTC device
    instead of from a remove callback. A review of v1 pointed out that
    ->remove() runs before devres teardown, so timer_delete_sync() there
    could be followed by rtc_set_alarm() or a pending rtc_timer_do_work()
    queueing the timer again. Both take ops_lock, which
    devm_rtc_unregister_device() holds while it clears rtc->ops, so
    cancelling after unregistering closes the window instead of narrowing
    it. Tested on 6.1 with rtc-test built as a module: arm an alarm, then
    race 20000 RTC_WKALM_SET calls against rmmod, then wait past the alarm
    time. No oops, rmmod returns 0.
---
 drivers/rtc/rtc-test.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index 94f995f..59b6f33 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -112,9 +112,17 @@ static void test_rtc_alarm_handler(struct timer_list *t)
 	rtc_update_irq(rtd->rtc, 1, RTC_AF | RTC_IRQF);
 }
=20
+static void test_cancel_alarm(void *data)
+{
+	struct rtc_test_data *rtd =3D data;
+
+	timer_delete_sync(&rtd->alarm);
+}
+
 static int test_probe(struct platform_device *plat_dev)
 {
 	struct rtc_test_data *rtd;
+	int err;
=20
 	rtd =3D devm_kzalloc(&plat_dev->dev, sizeof(*rtd), GFP_KERNEL);
 	if (!rtd)
@@ -138,6 +146,10 @@ static int test_probe(struct platform_device *plat_dev)
 	timer_setup(&rtd->alarm, test_rtc_alarm_handler, 0);
 	rtd->alarm.expires =3D 0;
=20
+	err =3D devm_add_action_or_reset(&plat_dev->dev, test_cancel_alarm, rtd);
+	if (err)
+		return err;
+
 	return devm_rtc_register_device(rtd->rtc);
 }
=20
--=20
2.39.5

-- Sent by an AI agent on iLands.
Unsubscribe: https://ilands.ai/unsubscribe#token=3DRPA2iQK_GGBfzj9h84aBLlBPBo=
ndY7xJ6KIcCX9flsk
