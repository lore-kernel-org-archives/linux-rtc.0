Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370068;
	b=WSIXLmXwdAfFoqv1wyiORjq9CQtsEizbJgOd+JG3eR0/EogZ8Dh5eyo3xVWb5gJawsxv
	 8WblpUcL24gtKCXzJTem7qgZyJPqDdVhI9NRmWJ1zhEiIg8WEOCB6fIxdPLslHhZs1VJs
	 BUsOQIVCFLhX49Y5knusTWURYEXcef09S4jf9PGCqkhlfUfkjno1fTT6mkwmlnlHtDUHe
	 vxm9mkOZQlQi8HTcEDru8bQ0BT81oQeq7nd+ED5Lg/tsr8EwgHDzd44VFv2FGl6R++4H4
	 jh3oOj7bI6iksvVIyW5vAnTwr7Be6ss22ZY+nHK0eAw/OAm7jdtmnHzV5WBs/vYDAwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370068;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xkcrzWg+8JFRMIu2/jGzqd5P52f/0dkCC8nKpO19TmY=;
	b=ESvAjw35BbSowxwF5Oz9W0dV1C1xdrNPZXMRFXOSJ4XF+B6xIIyUcYpygbvmrfKmaTDt
	 POrW+CfQDSRbRiCgeNyn1prT8Ul+1OMVoZizlKhXEcJKXxgsf00Vh7R0QDwLv3xa+KApa
	 cX0I8R7w8dxQtYlX/b1SxN7lBwO9UNiM6helOR5qfXifiAC7Jd+OZqt8UbeUEMzEneH4P
	 PMDwG1AcbiQqygrk7ZPrgIPS1Jc1gzk8aUSxg4c5X0yuca+JiHN1o9c5La40voHxVwlLd
	 Nqfg6t8s4DHRnfGA9QkjkXAWLRDEpFe5wnyhUhQYpHn4FeizhLP8sABm39ssIqP9BYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgPAsfkz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E773E606A321
	for <linux-rtc@vger.kernel.org>; Wed, 11 Nov 2026 04:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgPAsfkz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFB31F0089F;
	Wed, 11 Nov 2026 04:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370067;
	bh=xkcrzWg+8JFRMIu2/jGzqd5P52f/0dkCC8nKpO19TmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FgPAsfkzvHvcykg9dxnhY+/kZeZmJcWc8cws9rIUx2FlNbua0cJwLH14tZtysIwqz
	 2svweqRPxV1T/4jBySf4lkJnVciMBDQr6qkVueIq67q8vxBzCf0Tdkh0TmR+ahVQVu
	 /3re5i1XiDq/AxGuJToajYJz99NbJEn/gbQuNNF1zwcv9tmPVx9EB3jIDrUdue8Ja0
	 j6ptO46xDooxysbguMtc76jSGb9zfUXQH+IFBd/fFaqTy3Qd4IkOAnHvjauZCi6Mlz
	 m6+5zv2CIwp6zZPOckgHapcyj5rmhg3ivS4iKhzDcD8XOBMGOo+W7ICUJvWkE0045E
	 yMcxnZR9ff+eA==
Message-ID: <sashiko-outbox-208262@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] soc: qcom: pmic_glink: Add GIO pmic_glink instance
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261110-gio-framework-rtc-driver-2026-10-12-v1-2-e4164178183a@oss.qualcomm.com>
References: <20261110-gio-framework-rtc-driver-2026-10-12-v1-0-e4164178183a@oss.qualcomm.com>
 <20261110-gio-framework-rtc-driver-2026-10-12-v1-2-e4164178183a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 04:07:46 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] soc: qcom: pmic_glink: missing state checks in GIO read/write
  paths
- [Medium] soc: qcom: pmic_glink: uncleared pending state in
  pmic_glink_gio_callback()
- [Medium] soc: qcom: pmic_glink_gio: use-after-free of pgio->client on
  unbind
- [Low] soc: qcom: pmic_glink: unused variable ret in
  pmic_glink_gio_init_work()
--

commit 7a554fdd48ae7b7ceeeac57f7e2ff18534912ac9
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

soc: qcom: pmic_glink: Add GIO pmic_glink instance

This commit adds the PMIC GLINK transport driver for the Qualcomm GIO
(General I/O) interface and enables the GIO auxiliary device on Glymur.

> diff --git a/drivers/soc/qcom/pmic_glink_gio.c b/drivers/soc/qcom/pmic_gl=
ink_gio.c
> new file mode 100644
> index 0000000000000..f222c0d59220f
> --- /dev/null
> +++ b/drivers/soc/qcom/pmic_glink_gio.c
[ ... ]
> +static int pmic_glink_gio_write_sync(struct pmic_glink_gio *pgio, u32 ad=
dr,
> +				     const u8 *data, size_t length)
> +{
> +	struct gio_write_req *req =3D &pgio->write_req;
> +	int ret;
> +
> +	if (!data || !length)
> +		return -EFAULT;
> +
> +	if (length > GIO_RW_BUFFER_SIZE) {
> +		dev_err(pgio->dev, "Write length %zu exceeds maximum buffer size %d\n",
> +			length, GIO_RW_BUFFER_SIZE);
> +		return -EINVAL;
> +	}
> +
> +	reinit_completion(&pgio->ack);
> +
> +	req->hdr.owner =3D cpu_to_le32(PMIC_GLINK_OWNER_GIO);
> +	req->hdr.type =3D cpu_to_le32(PMIC_GLINK_REQ_RESP);
> +	req->hdr.opcode =3D cpu_to_le32(GIO_OPCODE_BLOCK_WRITE);
> +	req->offset =3D cpu_to_le32(addr);
> +	req->length =3D cpu_to_le32(length);
> +	memcpy(req->data, data, length);
> +
> +	scoped_guard(spinlock_irqsave, &pgio->lock) {
> +		pgio->pending =3D true;
> +		pgio->pending_opcode =3D GIO_OPCODE_BLOCK_WRITE;
> +	}

[Severity: Medium]
Can pmic_glink_gio_write_sync() and pmic_glink_gio_read() arm a
transaction after the service has already gone down or removal has
started?

Callers check READ_ONCE(gio->online) or READ_ONCE(pgio->service_up)
without holding pgio->lock:

CPU0                              CPU1
pmic_glink_gio_init_work()
  if (!READ_ONCE(pgio->service_up))
                                  pmic_glink_gio_pdr_notify(..., DOWN)
                                    guard(spinlock_irqsave)(&pgio->lock)
                                    WRITE_ONCE(pgio->service_up, false)
                                    /* pgio->pending is false */
                                    pmic_gio_set_state(..., DOWN)
  pmic_glink_gio_enable_alerts()
    ...
      pmic_glink_gio_write_sync()
        reinit_completion(&pgio->ack)
        scoped_guard(..., &pgio->lock)
          pgio->pending =3D true
        pmic_glink_send(...)
        pmic_glink_gio_wait_ack()  <-- waits full 5s timeout

Because neither function checks pgio->removing or pgio->service_up
(or calls reinit_completion(&pgio->ack)) under pgio->lock, a concurrent
PDR down notification or pmic_glink_gio_remove() misses pgio->pending
and leaves the caller blocked for PMIC_GLINK_SEND_TIMEOUT.

[ ... ]
> +static void pmic_glink_gio_init_work(struct work_struct *work)
> +{
> +	struct pmic_glink_gio *pgio =3D container_of(work, struct pmic_glink_gi=
o, init_work);
> +	int ret;
> +
> +	if (!READ_ONCE(pgio->service_up))
> +		return;
> +
> +	pmic_glink_gio_enable_alerts(pgio);
> +}

[Severity: Low]
Does the unused local variable ret here trigger a -Wunused-variable
warning (and break the build under CONFIG_WERROR=3Dy) at this commit?
ret is only used later in the series in commit "rtc: Add Qualcomm GIO
RTC driver", so its declaration should be moved there to keep bisection
clean.

[ ... ]
> +	switch (opcode) {
> +	case GIO_OPCODE_BLOCK_READ:
> +		if (len !=3D sizeof(struct gio_read_resp)) {
> +			dev_warn(pgio->dev, "Invalid read response message, length: %zu\n", l=
en);
> +			return;
> +		}
> +
> +		rx_resp =3D data;
> +
> +		scoped_guard(spinlock_irqsave, &pgio->lock) {
> +			if (!pgio->pending || pgio->pending_opcode !=3D GIO_OPCODE_BLOCK_READ=
) {
> +				dev_warn(pgio->dev, "Unexpected GIO read response, dropping\n");
> +				return;
> +			}
> +
> +			if (le32_to_cpu(rx_resp->ret_code) !=3D 0) {
> +				pgio->ack_error =3D -EREMOTEIO;
> +				dev_warn(pgio->dev, "GIO read response failed (%u)\n",
> +					 le32_to_cpu(rx_resp->ret_code));
> +			} else if (pgio->buf) {
> +				copy_size =3D min_t(size_t, pgio->buf_size, GIO_RW_BUFFER_SIZE);
> +				memcpy(pgio->buf, rx_resp->data, copy_size);
> +			}
> +			complete(&pgio->ack);
> +		}
> +		break;
> +
> +	case GIO_OPCODE_BLOCK_WRITE:
> +		if (len !=3D sizeof(struct gio_write_resp)) {
> +			dev_warn(pgio->dev, "Invalid write response message, length: %zu\n", =
len);
> +			return;
> +		}
> +
> +		tx_resp =3D data;
> +
> +		scoped_guard(spinlock_irqsave, &pgio->lock) {
> +			if (!pgio->pending || pgio->pending_opcode !=3D GIO_OPCODE_BLOCK_WRIT=
E) {
> +				dev_warn(pgio->dev, "Unexpected GIO write response, dropping\n");
> +				return;
> +			}
> +
> +			if (le32_to_cpu(tx_resp->ret_code) !=3D 0) {
> +				pgio->ack_error =3D -EREMOTEIO;
> +				dev_warn(pgio->dev, "GIO write response failed (%u)\n",
> +					 le32_to_cpu(tx_resp->ret_code));
> +			}
> +			complete(&pgio->ack);
> +		}
> +		break;

[Severity: Medium]
Should pmic_glink_gio_callback() clear pgio->pending and pgio->buf under
pgio->lock before calling complete(&pgio->ack)?

Leaving pgio->pending set until the waiter wakes up in
pmic_glink_gio_wait_ack() creates a window where another event can
corrupt the completed transaction's state:

CPU0                              CPU1
pmic_glink_gio_wait_ack()
  wait_for_completion_timeout()
                                  pmic_glink_gio_callback()
                                    lock(&pgio->lock)
                                    memcpy(pgio->buf, ...)
                                    complete(&pgio->ack)
                                    unlock(&pgio->lock)
                                  pmic_glink_gio_pdr_notify(..., DOWN)
                                    lock(&pgio->lock)
                                    if (!service_up && pgio->pending)
                                      pgio->ack_error =3D -ENETRESET
                                    unlock(&pgio->lock)
  lock(&pgio->lock)
  ret =3D pgio->ack_error           <-- returns -ENETRESET instead of 0

A duplicate or late firmware response arriving in that window will
similarly see pgio->pending =3D=3D true and overwrite pgio->buf or
pgio->ack_error.

[ ... ]
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
> +	pgio->client =3D devm_pmic_glink_client_alloc(dev, PMIC_GLINK_OWNER_GIO,
> +						    pmic_glink_gio_callback,
> +						    pmic_glink_gio_pdr_notify,
> +						    pgio);
> +	if (IS_ERR(pgio->client))
> +		return PTR_ERR(pgio->client);
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
> +			pgio->pending =3D false;
> +			pgio->buf =3D NULL;
> +			pgio->buf_size =3D 0;
> +			pgio->ack_error =3D -ENODEV;
> +			complete(&pgio->ack);
> +		}
> +		pmic_gio_set_state(pgio->gio, PMIC_GIO_STATE_DOWN);
> +	}
> +
> +	cancel_work_sync(&pgio->init_work);
> +	flush_workqueue(pgio->wq);
> +}

[Severity: Medium]
Can an in-flight regmap access (such as a regmap debugfs read) use
pgio->client after it is freed during unbind?

devm_pmic_gio_register() (which calls devm_regmap_init()) is registered
before devm_pmic_glink_client_alloc(), so devres frees pgio->client
before regmap_exit() removes the debugfs entries and drains active
readers:

CPU0                              CPU1
regmap_debugfs_read_file()
  ...
  pmic_gio_regmap_bus_read()
    if (!READ_ONCE(gio->online))
                                  pmic_glink_gio_remove()
                                    pgio->removing =3D true
                                    pmic_gio_set_state(..., DOWN)
                                  devres_release_all()
                                    _devm_pmic_glink_release_client()
                                      kfree(pgio->client)
    pmic_glink_gio_read()
      pmic_glink_send(pgio->client, ...)
        client->pg                <-- use-after-free

Allocating pgio->client before devm_pmic_gio_register() ensures
devm_regmap_release() finishes draining regmap users before pgio->client
is released.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-gio-framew=
ork-rtc-driver-2026-10-12-v1-0-e4164178183a@oss.qualcomm.com?part=3D2
