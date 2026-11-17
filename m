Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794901791;
	b=KaxsSFRAnHqrYXj2nnBPaw0ZmMpAYrAIGhtAAIqGKDaiIRN/PL14rPQlgRzbvV4ZbbGo
	 zvpi8HR2XEMNZ7NsgpZoOCgUt6GoqDA2KxL9L3KuR+HP4Sha8BbUJVWreSj2cEt+9cEXE
	 qLYBuCf/ZvZ6lYR6dGiu2QyJhQa8QLIQ6mempdi57baoZkx35XJtIsPU+I7tZ6YeiuU2A
	 G+ObQiPPOv7t+d4tS2eACr5x1wkpqt8ryFF2GLbFVq+puF7yWhB/9Zskup6a4iaqSXIs/
	 41GiuI0AjutlNJ6cIgK2SrtIMqOtkW/HcF9bS1VVInESI52GVMq1FhiEW7XB3ZVrq6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794901791;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5E7+Yrh0UbN6KjTmdUqubpJq2LDoBTWYtYstnGPLl2s=;
	b=sPR8arzOZyrvNBUpj3X0Ap6+dHKQMVt6RIUcuAoT4PIVBjVrNIPFBBoofYuvKQ8ByB57
	 AOXQP/O+XdEmMCWVjpmVBxno8K+EboF23D4YpcLEd0sox7CeoSCJwbAeCNTCSht5ULQ0G
	 syHe4mFePsoGBCUdPLMb6TYvmCDPfgYjSs8lVck160OI8MscEV/89lzqpuajxCq7fConp
	 t7s7E/zf8ZXCmtVOirsP5I122a0crfE8r4VezwM0XX4/qGPzrW9Cqr5SJ3wZCJP8v7Q8I
	 LV/Hh9MwqvEipVJSSRsifS2LbLnLRVX6hz6ESzg/gtFlbgxKe0814uD+gWrISi4QBSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KcdvMiIV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0E1606A31C
	for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KcdvMiIV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B92B1F000C4;
	Tue, 17 Nov 2026 07:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794901791;
	bh=5E7+Yrh0UbN6KjTmdUqubpJq2LDoBTWYtYstnGPLl2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KcdvMiIVc4aRGCURFdWXbr3VHLJDIecjyzkfXeFUnDrmrGlCEJY6YIBQB1xz9yFq4
	 vf11p1ULOaSw7tUuLn9Ozpw3Y83P1TZNYm4pSQbK51M4z7vvp8UVg/YwkrowSsOw9M
	 iNfkQkPIBNtPsKg6EhVsCBOCSUnqTkSqRecG4GW2Luoe5LbRdiQmIqBTPQWYaYafo9
	 JVhGUnuT/bqGnj70txzGPLf78VeDdy6937jawZipAAKqYGvne6OnNmcIbgjkbgG9w4
	 IYRSDshhkSLLhuIe5lQHuXKNjj0sF9BK/JEIiUi5hfh216c956Gfu+ukHKqrUMrP8e
	 P8vQY8LFgKI3g==
Message-ID: <sashiko-outbox-218383@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] soc: qcom: pmic_glink: Add GIO pmic_glink
 instance
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261116-gio-framework-rtc-driver-2026-10-12-v2-2-b60e6fe33831@oss.qualcomm.com>
References: <20261116-gio-framework-rtc-driver-2026-10-12-v2-0-b60e6fe33831@oss.qualcomm.com>
 <20261116-gio-framework-rtc-driver-2026-10-12-v2-2-b60e6fe33831@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 07:49:50 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] soc: qcom: pmic_glink_gio: race queuing init_work during
  remove()
--

commit 48ca37803eec968c264abeb517c30d1b0bb846fc
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

soc: qcom: pmic_glink: Add GIO pmic_glink instance

This commit adds a PMIC GLINK auxiliary driver for the General I/O (GIO)
register space and alert interface exposed by the SoCCP firmware, and
enables the GIO auxiliary device on Glymur.

> diff --git a/drivers/soc/qcom/pmic_glink_gio.c b/drivers/soc/qcom/pmic_gl=
ink_gio.c
> new file mode 100644
> index 0000000000000..9a28f88152b25
> --- /dev/null
> +++ b/drivers/soc/qcom/pmic_glink_gio.c
[ ... ]
> +static void pmic_glink_gio_pdr_notify(void *priv, int state)
> +{
> +	struct pmic_glink_gio *pgio =3D priv;
> +	bool service_up;
> +
> +	service_up =3D state =3D=3D SERVREG_SERVICE_STATE_UP;
> +
> +	scoped_guard(spinlock_irqsave, &pgio->lock) {
> +		if (pgio->removing)
> +			return;
> +
> +		WRITE_ONCE(pgio->service_up, service_up);
> +		if (!service_up && pgio->pending) {
> +			pgio->ack_error =3D -ENETRESET;
> +			pmic_glink_gio_complete_transaction(pgio);
> +		}
> +
> +		if (!service_up)
> +			pmic_gio_set_state(pgio->gio, PMIC_GIO_STATE_DOWN);
> +	}
> +
> +	if (service_up)
> +		queue_work(pgio->wq, &pgio->init_work);
> +}

[ ... ]

> +static int pmic_glink_gio_probe(struct auxiliary_device *adev,
> +				const struct auxiliary_device_id *id)
> +{
> +	struct pmic_glink_gio *pgio;
> +	struct device *dev =3D &adev->dev;
> +	int ret;
> +
> +	pgio =3D devm_kzalloc(dev, sizeof(*pgio), GFP_KERNEL);
> +	if (!pgio)
> +		return -ENOMEM;
> +
> +	pgio->dev =3D dev;
> +	spin_lock_init(&pgio->lock);
> +	init_completion(&pgio->ack);
> +	INIT_WORK(&pgio->init_work, pmic_glink_gio_init_work);
> +	dev_set_drvdata(dev, pgio);
> +
> +	pgio->client =3D devm_pmic_glink_client_alloc(dev, PMIC_GLINK_OWNER_GIO,
> +						    pmic_glink_gio_callback,
> +						    pmic_glink_gio_pdr_notify,
> +						    pgio);
> +	if (IS_ERR(pgio->client))
> +		return PTR_ERR(pgio->client);
> +
> +	pgio->gio =3D devm_pmic_gio_register(dev, &pmic_glink_gio_ops, pgio);
> +	if (IS_ERR(pgio->gio))
> +		return dev_err_probe(dev, PTR_ERR(pgio->gio), "failed to register GIO =
device\n");
> +
> +	pgio->wq =3D alloc_ordered_workqueue("pmic_glink_gio", 0);
> +	if (!pgio->wq)
> +		return -ENOMEM;
> +
> +	ret =3D devm_add_action_or_reset(dev, pmic_glink_gio_destroy_wq, pgio->=
wq);
> +	if (ret)
> +		return ret;
> +
> +	pmic_glink_client_register(pgio->client);
> +
> +	return 0;
> +}
> +
> +static void pmic_glink_gio_remove(struct auxiliary_device *adev)
> +{
> +	struct pmic_glink_gio *pgio =3D dev_get_drvdata(&adev->dev);
> +
> +	scoped_guard(spinlock_irqsave, &pgio->lock) {
> +		pgio->removing =3D true;
> +		WRITE_ONCE(pgio->service_up, false);
> +		if (pgio->pending) {
> +			pgio->ack_error =3D -ENODEV;
> +			pmic_glink_gio_complete_transaction(pgio);
> +		}
> +		pmic_gio_set_state(pgio->gio, PMIC_GIO_STATE_DOWN);
> +	}
> +
> +	cancel_work_sync(&pgio->init_work);
> +	flush_workqueue(pgio->wq);
> +}

[Severity: Medium]
Can pmic_glink_gio_pdr_notify() queue pgio->init_work onto pgio->wq while
or after the workqueue is destroyed during teardown?

pmic_glink_gio_pdr_notify() checks pgio->removing under pgio->lock, but
releases pgio->lock before calling queue_work(pgio->wq, &pgio->init_work).
In addition, pmic_glink_gio_probe() registers devm_pmic_glink_client_alloc()
before devm_add_action_or_reset(dev, pmic_glink_gio_destroy_wq, pgio->wq),
so devres destroys pgio->wq before _devm_pmic_glink_release_client()
unlinks pgio->client under pg->client_lock:

CPU0                                  CPU1
pmic_glink_state_notify_clients()
  lock(&pg->client_lock)
  pmic_glink_gio_pdr_notify()
    lock(&pgio->lock)
    /* pgio->removing is false */
    unlock(&pgio->lock)
                                      pmic_glink_gio_remove()
                                        lock(&pgio->lock)
                                        pgio->removing =3D true
                                        unlock(&pgio->lock)
                                        cancel_work_sync(&pgio->init_work)
                                        flush_workqueue(pgio->wq)
                                      devres_release_all()
                                        pmic_glink_gio_destroy_wq()
                                          destroy_workqueue(pgio->wq)
    queue_work(pgio->wq, ...)
      <-- WARN_ONCE / use-after-free on pgio->wq

Keeping queue_work(pgio->wq, &pgio->init_work) inside the pgio->lock
critical section in pmic_glink_gio_pdr_notify() (as GIO_OPCODE_ALERT_IND
does in pmic_glink_gio_callback()) avoids queuing work after pgio->removing
is set.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-gio-framew=
ork-rtc-driver-2026-10-12-v2-0-b60e6fe33831@oss.qualcomm.com?part=3D2
